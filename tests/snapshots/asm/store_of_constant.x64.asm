
store_of_constant.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<put_fields>:
               	movb	$0x7f, 0x1(%rdi)
               	movw	$0x2345, 0x2(%rdi)      # imm = 0x2345
               	movl	$0x80000001, 0x4(%rdi)  # imm = 0x80000001
               	movq	$-0x80000000, 0x8(%rdi) # imm = 0x80000000
               	retq

<put_q>:
               	movq	$0x7fffffff, (%rdi)     # imm = 0x7FFFFFFF
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$-0x80000001, %rcx      # imm = 0xFFFFFFFF7FFFFFFF
               	movq	%rcx, 0x10(%rdi)
               	movq	$0x0, 0x18(%rdi)
               	retq

<put_at>:
               	movb	$-0x3d, (%rdi,%rsi)
               	retq

<put_at32>:
               	movl	$0xfffffff9, (%rdi,%rsi,4) # imm = 0xFFFFFFF9
               	retq

<fill>:
               	xorl	%eax, %eax
               	movw	$0xfed4, (%rdi,%rax,2)  # imm = 0xFED4
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	retq

<put_volatile>:
               	movl	$0xdeadbeef, (%rdi)     # imm = 0xDEADBEEF
               	movl	$0x0, 0x10(%rdi)
               	retq

<put_packed>:
               	movq	$-0x3, 0x1(%rdi)
               	movl	$0x11223344, 0x9(%rdi)  # imm = 0x11223344
               	retq

<put_float>:
               	movl	$0x3fc00000, (%rdi)     # imm = 0x3FC00000
               	movl	$0x80000000, 0x4(%rdi)  # imm = 0x80000000
               	movq	$0x0, (%rsi)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x8(%rsi)
               	retq

<both>:
               	movl	$0x9, %eax
               	movq	%rax, (%rsi)
               	movq	%rax, (%rdi)
               	retq

<touch>:
               	addq	$0x1, (%rdi)
               	retq

<slot>:
               	subq	$0x18, %rsp
               	movq	$-0x5, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<read_then_clear>:
               	movsbq	(%rdi), %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rsi)
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	retq

<main>:
               	subq	$0xe8, %rsp
               	leaq	0x68(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	movzbq	0x69(%rsp), %rax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	movzwq	0x6a(%rsp), %rax
               	cmpl	$0x2345, %eax           # imm = 0x2345
               	jne	<addr>
               	movl	0x6c(%rsp), %eax
               	cmpl	$0x80000001, %eax       # imm = 0x80000001
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	0x70(%rsp), %rax
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0xb0(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	callq	<addr>
               	movq	0xb0(%rsp), %rax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	0xc0(%rsp), %rax
               	movabsq	$-0x80000001, %r11      # imm = 0xFFFFFFFF7FFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, 0xc8(%rsp)
               	jne	<addr>
               	movabsq	$-0x5555555555555556, %rax # imm = 0xAAAAAAAAAAAAAAAA
               	movq	%rax, 0x8(%rsp)
               	movq	$0x3, 0xd8(%rsp)
               	movq	0xd8(%rsp), %rsi
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movzbq	0xb(%rsp), %rax
               	cmpl	$0xc3, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	0x8(%rsp,%rax), %rdx
               	cmpl	$0xaa, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	0x8(%rsp), %rax
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0xaa, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x28(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8(%rax), %rdi
               	movq	0xd8(%rsp), %rax
               	negq	%rax
               	leaq	0x2(%rax), %rsi
               	callq	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	0x2c(%rsp), %eax
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	movl	0x30(%rsp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	0x34(%rsp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movl	$0x5, %esi
               	callq	<addr>
               	movswq	0x38(%rsp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xe8, %rsp
               	retq
               	movswq	0x3a(%rsp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0x3c(%rsp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0x3e(%rsp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0x40(%rsp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0x42(%rsp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	movl	0x80(%rsp), %eax
               	cmpl	$0xdeadbeef, %eax       # imm = 0xDEADBEEF
               	jne	<addr>
               	cmpl	$0x0, 0x90(%rsp)
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movzbq	0xc(%rax), %r10
               	movb	%r10b, 0xc(%rdi)
               	callq	<addr>
               	movq	0x49(%rsp), %rax
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movl	0x51(%rsp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	leaq	0x98(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	callq	<addr>
               	movss	0x58(%rsp), %xmm0
               	movss	%xmm0, 0x20(%rsp)
               	movl	0x20(%rsp), %eax
               	cmpl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	jne	<addr>
               	movss	0x5c(%rsp), %xmm0
               	movss	%xmm0, 0x20(%rsp)
               	movl	0x20(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	jne	<addr>
               	movss	0x60(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xe8, %rsp
               	retq
               	movsd	0x98(%rsp), %xmm0
               	movq	%xmm0, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	0xa0(%rsp), %xmm0
               	movq	%xmm0, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsd	0xa8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xe8, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	leaq	0x10(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0xe8, %rsp
               	retq
               	callq	<addr>
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0xe8, %rsp
               	retq
               	movb	$0x5, 0x20(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpb	$0x0, 0x20(%rsp)
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0xe8, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0xe8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xe8, %rsp
               	retq
               	movl	$0xa, %eax
               	addq	$0xe8, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0xe8, %rsp
               	retq
               	movl	$0x5, %eax
               	addq	$0xe8, %rsp
               	retq
