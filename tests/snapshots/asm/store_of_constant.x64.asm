
store_of_constant.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%rsi)
               	retq

<both>:
               	movl	$0x9, %eax
               	movq	%rax, (%rsi)
               	movq	%rax, (%rdi)
               	retq

<touch>:
               	movq	(%rdi), %rax
               	incq	%rax
               	movq	%rax, (%rdi)
               	retq

<slot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$-0x5, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	leave
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	leaq	-0x78(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	movzbq	-0x77(%rbp), %rax
               	xorq	$0x7f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzwq	-0x76(%rbp), %rax
               	xorq	$0x2345, %rax           # imm = 0x2345
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x74(%rbp), %eax
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x70(%rbp), %rax
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	callq	<addr>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x20(%rbp), %rax
               	movabsq	$-0x80000001, %r11      # imm = 0xFFFFFFFF7FFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x18(%rbp)
               	jne	<addr>
               	leaq	-0xd8(%rbp), %rdi
               	movabsq	$-0x5555555555555556, %rax # imm = 0xAAAAAAAAAAAAAAAA
               	movq	%rax, -0xd8(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	movq	-0x8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0xd8(%rbp), %rcx
               	movzbq	-0xd5(%rbp), %rax
               	xorq	$0xc3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0xaa, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0xaa, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8(%rax), %rdi
               	movq	-0x8(%rbp), %rax
               	negq	%rax
               	leaq	0x2(%rax), %rsi
               	callq	<addr>
               	movl	-0xb8(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0xb4(%rbp), %eax
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	movl	-0xb0(%rbp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0xac(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0xa8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movl	$0x5, %esi
               	callq	<addr>
               	movswq	-0xa8(%rbp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movswq	-0xa6(%rbp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	-0xa4(%rbp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	-0xa2(%rbp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	-0xa0(%rbp), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	-0x9e(%rbp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	movl	-0x60(%rbp), %eax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x50(%rbp)
               	jne	<addr>
               	leaq	-0x98(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movzbq	0xc(%rax), %r10
               	movb	%r10b, 0xc(%rdi)
               	callq	<addr>
               	leaq	-0x98(%rbp), %rax
               	movq	0x1(%rax), %rcx
               	cmpq	$-0x3, %rcx
               	jne	<addr>
               	movl	0x9(%rax), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x88(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	leaq	-0x48(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	callq	<addr>
               	movss	-0x88(%rbp), %xmm0
               	movss	%xmm0, -0xc0(%rbp)
               	movl	-0xc0(%rbp), %eax
               	cmpl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	jne	<addr>
               	movss	-0x84(%rbp), %xmm0
               	movss	%xmm0, -0xc0(%rbp)
               	movl	-0xc0(%rbp), %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movss	-0x80(%rbp), %xmm0
               	movl	$0x41100000, %eax       # imm = 0x41100000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movsd	-0x48(%rbp), %xmm0
               	movsd	%xmm0, -0xc0(%rbp)
               	cmpq	$0x0, -0xc0(%rbp)
               	jne	<addr>
               	movsd	-0x40(%rbp), %xmm0
               	movsd	%xmm0, -0xc0(%rbp)
               	movq	-0xc0(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x0, -0xd0(%rbp)
               	movq	$0x0, -0xc8(%rbp)
               	leaq	-0xd0(%rbp), %rdi
               	leaq	-0xc8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movb	$0x5, -0xc0(%rbp)
               	leaq	-0xc0(%rbp), %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpb	$0x0, -0xc0(%rbp)
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
