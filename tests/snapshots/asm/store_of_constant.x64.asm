
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
               	leaq	-0xd0(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x7f, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzwq	0x2(%rax), %rcx
               	xorq	$0x2345, %rcx           # imm = 0x2345
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0xb8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	callq	<addr>
               	leaq	-0xb8(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	0x10(%rax), %rcx
               	movabsq	$-0x80000001, %r11      # imm = 0xFFFFFFFF7FFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rax)
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	movabsq	$-0x5555555555555556, %rax # imm = 0xAAAAAAAAAAAAAAAA
               	movq	%rax, (%rdi)
               	movq	$0x3, -0xd8(%rbp)
               	movq	-0xd8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x90(%rbp), %rcx
               	movzbq	0x3(%rcx), %rax
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
               	leaq	-0x90(%rbp), %rax
               	leaq	0x4(%rax), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0xaa, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8(%rax), %rdi
               	movq	-0xd8(%rbp), %rax
               	negq	%rax
               	leaq	0x2(%rax), %rsi
               	callq	<addr>
               	movslq	-0x88(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	0x4(%rax), %rcx
               	cmpl	$-0x7, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x78(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movl	$0x5, %esi
               	callq	<addr>
               	leaq	-0x78(%rbp), %rax
               	movswq	(%rax), %rcx
               	cmpl	$0xfffffed4, %ecx       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movswq	0x2(%rax), %rcx
               	cmpl	$0xfffffed4, %ecx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0x4(%rax), %rcx
               	cmpl	$0xfffffed4, %ecx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0x6(%rax), %rcx
               	cmpl	$0xfffffed4, %ecx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0x8(%rax), %rcx
               	cmpl	$0xfffffed4, %ecx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	0xa(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	callq	<addr>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movzbq	0xc(%rax), %r10
               	movb	%r10b, 0xc(%rdi)
               	callq	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	0x1(%rax), %rcx
               	cmpq	$-0x3, %rcx
               	jne	<addr>
               	movslq	0x9(%rax), %rax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	leaq	-0x30(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0xe0(%rbp)
               	movl	-0xe0(%rbp), %ecx
               	cmpl	$0x3fc00000, %ecx       # imm = 0x3FC00000
               	jne	<addr>
               	movss	0x4(%rax), %xmm0
               	movss	%xmm0, -0xe0(%rbp)
               	movl	-0xe0(%rbp), %ecx
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movss	0x8(%rax), %xmm0
               	movl	$0x41100000, %eax       # imm = 0x41100000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rax
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0xe0(%rbp)
               	cmpq	$0x0, -0xe0(%rbp)
               	jne	<addr>
               	movsd	0x8(%rax), %xmm0
               	movsd	%xmm0, -0xe0(%rbp)
               	movq	-0xe0(%rbp), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movsd	0x10(%rax), %xmm0
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
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
               	movb	$0x5, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpb	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
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
