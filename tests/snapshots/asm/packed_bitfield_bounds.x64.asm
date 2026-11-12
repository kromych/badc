
packed_bitfield_bounds.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1e, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%edi, %edi
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	cmpq	$-0x1, %r12
               	je	<addr>
               	leaq	(%r12,%rbx), %rdi
               	xorl	%edx, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	(%r12,%rbx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x3(%rax), %rdx
               	leaq	-0x5(%rax), %rbx
               	leaq	-0x6(%rax), %r12
               	leaq	-0x7(%rax), %rcx
               	leaq	-0xe(%rax), %rdi
               	leaq	-0x9(%rax), %r8
               	leaq	-0x11(%rax), %rsi
               	leaq	-0x10(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xf(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xe(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xd(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xc(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xb(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xa(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x9(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x8(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x7(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x6(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x5(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x4(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x3(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x2(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x1(%rax), %r13
               	movb	$-0x1, (%r13)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r13
               	shlq	$0x10, %r13
               	orq	%r13, %r9
               	andq	$-0x400000, %r9         # imm = 0xFFC00000
               	orq	$0x3ffffb, %r9          # imm = 0x3FFFFB
               	movw	%r9w, (%rdx)
               	shrq	$0x10, %r9
               	movb	%r9b, 0x2(%rdx)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r13
               	movq	%r13, %r14
               	shlq	$0x10, %r14
               	orq	%r9, %r14
               	shlq	$0x2a, %r14
               	sarq	$0x2a, %r14
               	addq	$0x7, %r14
               	andq	$0x3fffff, %r14         # imm = 0x3FFFFF
               	shlq	$0x10, %r13
               	orq	%r13, %r9
               	andq	$-0x400000, %r9         # imm = 0xFFC00000
               	orq	%r14, %r9
               	movw	%r9w, (%rdx)
               	shrq	$0x10, %r9
               	movb	%r9b, 0x2(%rdx)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r13
               	shlq	$0x10, %r13
               	orq	%r13, %r9
               	shlq	$0x2a, %r9
               	sarq	$0x2a, %r9
               	cmpl	$0x2, %r9d
               	jne	<addr>
               	leaq	-0x1(%rax), %r9
               	movzbq	(%r9), %r9
               	cmpl	$0xc0, %r9d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xf(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xe(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xd(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xc(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xb(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xa(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x9(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x8(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x7(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x6(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x5(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x4(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x3(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x2(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x1(%rax), %r13
               	movb	$-0x1, (%r13)
               	movl	(%rbx), %r9d
               	movzbq	0x4(%rbx), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %r9
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r9
               	movabsq	$0xedcba9877, %r11      # imm = 0xEDCBA9877
               	orq	%r11, %r9
               	movl	%r9d, (%rbx)
               	shrq	$0x20, %r9
               	movb	%r9b, 0x4(%rbx)
               	movl	(%rbx), %r9d
               	movzbq	0x4(%rbx), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %r9
               	shlq	$0x1c, %r9
               	sarq	$0x1c, %r9
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %r9
               	jne	<addr>
               	leaq	-0x1(%rax), %r9
               	movzbq	(%r9), %r9
               	cmpl	$0xfe, %r9d
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	(%rbx), %r9d
               	movzbq	0x4(%rbx), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %r9
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r9
               	orq	$0x5, %r9
               	movl	%r9d, (%rbx)
               	shrq	$0x20, %r9
               	movb	%r9b, 0x4(%rbx)
               	movl	(%rbx), %r9d
               	movzbq	0x4(%rbx), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	shlq	$0x1c, %r9
               	sarq	$0x1c, %r9
               	cmpq	$0x5, %r9
               	jne	<addr>
               	leaq	-0x1(%rax), %rbx
               	movzbq	(%rbx), %r9
               	cmpl	$0xf0, %r9d
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xf(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xe(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xd(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xc(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xb(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xa(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x9(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x8(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x7(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x6(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x5(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x4(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x3(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x2(%rax), %r13
               	movb	$-0x1, (%r13)
               	movb	$-0x1, (%rbx)
               	movl	(%r12), %r9d
               	movzwq	0x4(%r12), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %r9
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	orq	%r11, %r9
               	movl	%r9d, (%r12)
               	shrq	$0x20, %r9
               	movw	%r9w, 0x4(%r12)
               	movl	(%r12), %r9d
               	movzwq	0x4(%r12), %rbx
               	movq	%rbx, %r13
               	shlq	$0x20, %r13
               	orq	%r9, %r13
               	shlq	$0x14, %r13
               	sarq	$0x14, %r13
               	decq	%r13
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %r13
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %r9
               	orq	%r13, %r9
               	movl	%r9d, (%r12)
               	shrq	$0x20, %r9
               	movw	%r9w, 0x4(%r12)
               	movl	(%r12), %r9d
               	movzwq	0x4(%r12), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	shlq	$0x14, %r9
               	sarq	$0x14, %r9
               	movabsq	$0x7fffffffffe, %r11    # imm = 0x7FFFFFFFFFE
               	cmpq	%r11, %r9
               	jne	<addr>
               	leaq	-0x1(%rax), %rbx
               	movzbq	(%rbx), %r9
               	cmpl	$0xf7, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %r12
               	movb	$-0x1, (%r12)
               	leaq	-0xf(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xe(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xd(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xc(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xb(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0xa(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x9(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x8(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x7(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x6(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x5(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x4(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x3(%rax), %r13
               	movb	$-0x1, (%r13)
               	leaq	-0x2(%rax), %r13
               	movb	$-0x1, (%r13)
               	movb	$-0x1, (%rbx)
               	movl	(%rcx), %r9d
               	movzwq	0x4(%rcx), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movzbq	0x6(%rcx), %rbx
               	shlq	$0x30, %rbx
               	orq	%rbx, %r9
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %r9
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	orq	%r11, %r9
               	movl	%r9d, (%rcx)
               	movq	%r9, %rbx
               	shrq	$0x20, %rbx
               	movw	%bx, 0x4(%rcx)
               	shrq	$0x30, %r9
               	movb	%r9b, 0x6(%rcx)
               	movl	(%rcx), %r9d
               	movzwq	0x4(%rcx), %rbx
               	movq	%rbx, %r13
               	shlq	$0x20, %r13
               	movq	%r9, %r14
               	orq	%r13, %r14
               	movzbq	0x6(%rcx), %r13
               	movq	%r13, %r10
               	shlq	$0x30, %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %r14
               	shlq	$0xc, %r14
               	sarq	$0xc, %r14
               	xorq	$0x5, %r14
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %r14
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	shlq	$0x30, %r13
               	orq	%r13, %r9
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %r9
               	orq	%r14, %r9
               	movl	%r9d, (%rcx)
               	movq	%r9, %rbx
               	shrq	$0x20, %rbx
               	movw	%bx, 0x4(%rcx)
               	shrq	$0x30, %r9
               	movb	%r9b, 0x6(%rcx)
               	movl	(%rcx), %r9d
               	movzwq	0x4(%rcx), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movzbq	0x6(%rcx), %rbx
               	shlq	$0x30, %rbx
               	orq	%rbx, %r9
               	shlq	$0xc, %r9
               	sarq	$0xc, %r9
               	cmpq	$-0x6, %r9
               	jne	<addr>
               	leaq	-0x1(%rax), %rbx
               	movzbq	(%rbx), %r9
               	cmpl	$0xff, %r9d
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	(%rcx), %r9d
               	movzwq	0x4(%rcx), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %r9
               	movzbq	0x6(%rcx), %r13
               	shlq	$0x30, %r13
               	orq	%r13, %r9
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %r9
               	movl	%r9d, (%rcx)
               	movq	%r9, %r13
               	shrq	$0x20, %r13
               	movw	%r13w, 0x4(%rcx)
               	shrq	$0x30, %r9
               	movb	%r9b, 0x6(%rcx)
               	movl	(%rcx), %r9d
               	movzwq	0x4(%rcx), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %r9
               	movzbq	0x6(%rcx), %r13
               	shlq	$0x30, %r13
               	orq	%r13, %r9
               	shlq	$0xc, %r9
               	sarq	$0xc, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	movzbq	(%rbx), %r9
               	cmpl	$0xf0, %r9d
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movb	$0x0, (%r12)
               	leaq	-0xf(%rax), %rbx
               	movb	$0x0, (%rbx)
               	leaq	-0xe(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0xd(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0xc(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0xb(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0xa(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x9(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x8(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x7(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x6(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x5(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x4(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x3(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x2(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x1(%rax), %r12
               	movb	$0x0, (%r12)
               	movzbq	(%rdx), %r9
               	andq	$-0x10, %r9
               	orq	$0x9, %r9
               	movb	%r9b, (%rdx)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r12
               	shlq	$0x10, %r12
               	orq	%r12, %r9
               	andq	$-0xfffff1, %r9         # imm = 0xFF00000F
               	orq	$0xedcbb0, %r9          # imm = 0xEDCBB0
               	movw	%r9w, (%rdx)
               	shrq	$0x10, %r9
               	movb	%r9b, 0x2(%rdx)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r12
               	shlq	$0x10, %r12
               	orq	%r12, %r9
               	sarq	$0x4, %r9
               	shlq	$0x2c, %r9
               	sarq	$0x2c, %r9
               	cmpl	$0xfffedcbb, %r9d       # imm = 0xFFFEDCBB
               	jne	<addr>
               	movzbq	(%rdx), %r9
               	andq	$0xf, %r9
               	cmpl	$0x9, %r9d
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r12
               	movq	%r12, %r13
               	shlq	$0x10, %r13
               	orq	%r9, %r13
               	sarq	$0x4, %r13
               	shlq	$0x2c, %r13
               	sarq	$0x2c, %r13
               	incq	%r13
               	andq	$0xfffff, %r13          # imm = 0xFFFFF
               	shlq	$0x10, %r12
               	orq	%r12, %r9
               	andq	$-0xfffff1, %r9         # imm = 0xFF00000F
               	shlq	$0x4, %r13
               	orq	%r13, %r9
               	movw	%r9w, (%rdx)
               	shrq	$0x10, %r9
               	movb	%r9b, 0x2(%rdx)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r12
               	shlq	$0x10, %r12
               	orq	%r12, %r9
               	sarq	$0x4, %r9
               	shlq	$0x2c, %r9
               	sarq	$0x2c, %r9
               	cmpl	$0xfffedcbc, %r9d       # imm = 0xFFFEDCBC
               	jne	<addr>
               	movzbq	(%rdx), %r9
               	andq	$0xf, %r9
               	cmpl	$0x9, %r9d
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %r12
               	movb	$-0x1, (%r12)
               	movb	$-0x1, (%rbx)
               	leaq	-0xe(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0xd(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0xc(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0xb(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0xa(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x9(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x8(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x7(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x6(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x5(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x4(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x3(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x2(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	leaq	-0x1(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %r13
               	shlq	$0x10, %r13
               	orq	%r13, %r9
               	andq	$-0x800000, %r9         # imm = 0xFF800000
               	orq	$0x2aaaaa, %r9          # imm = 0x2AAAAA
               	movw	%r9w, (%rdx)
               	shrq	$0x10, %r9
               	movb	%r9b, 0x2(%rdx)
               	movzwq	(%rdx), %r9
               	movzbq	0x2(%rdx), %rdx
               	shlq	$0x10, %rdx
               	orq	%r9, %rdx
               	andq	$0x7fffff, %rdx         # imm = 0x7FFFFF
               	cmpl	$0x2aaaaa, %edx         # imm = 0x2AAAAA
               	jne	<addr>
               	movzbq	(%rbx), %rdx
               	cmpl	$0xaa, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movb	$0x0, (%r12)
               	leaq	-0xf(%rax), %r9
               	movb	$0x0, (%r9)
               	leaq	-0xe(%rax), %rbx
               	movb	$0x0, (%rbx)
               	leaq	-0xd(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0xc(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0xb(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0xa(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x9(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x8(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x7(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x6(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x5(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x4(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x3(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x2(%rax), %r12
               	movb	$0x0, (%r12)
               	leaq	-0x1(%rax), %r12
               	movb	$0x0, (%r12)
               	movb	$0x5a, (%rcx)
               	movl	0x1(%rcx), %edx
               	movzwq	0x5(%rcx), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %rdx
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rdx
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	orq	%r11, %rdx
               	movl	%edx, 0x1(%rcx)
               	shrq	$0x20, %rdx
               	movw	%dx, 0x5(%rcx)
               	movl	0x1(%rcx), %edx
               	movzwq	0x5(%rcx), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %rdx
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movzbq	(%r12), %rdx
               	cmpl	$0xfe, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	0x1(%rcx), %edx
               	movzwq	0x5(%rcx), %r12
               	movq	%r12, %r13
               	shlq	$0x20, %r13
               	orq	%rdx, %r13
               	shrq	$0x4, %r13
               	shlq	$0x20, %r12
               	orq	%r12, %rdx
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rdx
               	orq	%r13, %rdx
               	movl	%edx, 0x1(%rcx)
               	shrq	$0x20, %rdx
               	movw	%dx, 0x5(%rcx)
               	movl	0x1(%rcx), %edx
               	movzwq	0x5(%rcx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rdx, %rcx
               	movabsq	$0xfedcba98765, %r11    # imm = 0xFEDCBA98765
               	cmpq	%r11, %rcx
               	jne	<addr>
               	leaq	-0x20(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x1f(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x1e(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x1d(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x1c(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x1b(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x1a(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x19(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x18(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x17(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x16(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x15(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x14(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x13(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x12(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x11(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x10(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	movb	$-0x1, (%r9)
               	movb	$-0x1, (%rbx)
               	leaq	-0xd(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0xc(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0xb(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0xa(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x9(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x8(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x7(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x6(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x5(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x4(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x3(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x2(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	leaq	-0x1(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	movb	$0x3, (%rdi)
               	movl	0x9(%rdi), %ecx
               	movzbq	0xd(%rdi), %r9
               	shlq	$0x20, %r9
               	orq	%r9, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x123456789abcdf0, %r9 # imm = 0xFEDCBA9876543210
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	orq	%r11, %rcx
               	movq	%r9, 0x1(%rdi)
               	movl	%ecx, 0x9(%rdi)
               	shrq	$0x20, %rcx
               	movb	%cl, 0xd(%rdi)
               	movl	0x9(%rdi), %ecx
               	movzbq	0xd(%rdi), %r9
               	shlq	$0x20, %r9
               	orq	%r9, %rcx
               	shlq	$0x1c, %rcx
               	orq	$0xfedcba9, %rcx        # imm = 0xFEDCBA9
               	movq	%rcx, %rbx
               	sarq	$0x1c, %rbx
               	shlq	$0x24, %rcx
               	movabsq	$0x876543210, %r11      # imm = 0x876543210
               	orq	%r11, %rcx
               	leaq	0x1(%rcx), %r9
               	cmpq	%rcx, %r9
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rbx, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movl	0x9(%rdi), %ebx
               	movzbq	0xd(%rdi), %r12
               	shlq	$0x20, %r12
               	orq	%r12, %rbx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rbx
               	orq	%rbx, %rcx
               	movq	%r9, 0x1(%rdi)
               	movl	%ecx, 0x9(%rdi)
               	shrq	$0x20, %rcx
               	movb	%cl, 0xd(%rdi)
               	movq	0x1(%rdi), %rcx
               	movl	0x9(%rdi), %r9d
               	movzbq	0xd(%rdi), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movq	%rcx, %rbx
               	shlq	$0x1c, %rbx
               	shlq	$0x1c, %r9
               	shrq	$0x24, %rcx
               	orq	%r9, %rcx
               	movq	%rcx, %r9
               	sarq	$0x1c, %r9
               	shrq	$0x1c, %rbx
               	shlq	$0x24, %rcx
               	orq	%rbx, %rcx
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	xorq	%r11, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%rdx), %rcx
               	cmpl	$0xf1, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	$-0x2, %rcx
               	movl	0x9(%rdi), %r9d
               	movzbq	0xd(%rdi), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r9
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %r9
               	movq	%rcx, 0x1(%rdi)
               	movl	%r9d, 0x9(%rdi)
               	shrq	$0x20, %r9
               	movb	%r9b, 0xd(%rdi)
               	movl	0x9(%rdi), %r9d
               	movzbq	0xd(%rdi), %rdi
               	shlq	$0x20, %rdi
               	orq	%r9, %rdi
               	shlq	$0x1c, %rdi
               	orq	$0xfffffff, %rdi        # imm = 0xFFFFFFF
               	movq	%rdi, %r9
               	sarq	$0x1c, %r9
               	shlq	$0x24, %rdi
               	movabsq	$0xffffffffe, %r11      # imm = 0xFFFFFFFFE
               	orq	%r11, %rdi
               	xorq	%rdi, %rcx
               	xorq	$-0x1, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%rdx), %rcx
               	cmpl	$0xff, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x20(%rax), %rdi
               	movb	$0x0, (%rdi)
               	leaq	-0x1f(%rax), %r9
               	movb	$0x0, (%r9)
               	leaq	-0x1e(%rax), %rbx
               	movb	$0x0, (%rbx)
               	leaq	-0x1d(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x1c(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x1b(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x1a(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x19(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x18(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x17(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x16(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x15(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x14(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x13(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x12(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x11(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x10(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0xf(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0xe(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0xd(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0xc(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0xb(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0xa(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x9(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x8(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x7(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x6(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x5(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x4(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x3(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x2(%rax), %rdx
               	movb	$0x0, (%rdx)
               	leaq	-0x1(%rax), %rdx
               	movb	$0x0, (%rdx)
               	movzbq	(%r8), %rcx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%r8)
               	movzbq	0x8(%r8), %rcx
               	andq	$-0xff, %rcx
               	orq	$0xaa, %rcx
               	movb	%cl, 0x8(%r8)
               	movq	(%r8), %rcx
               	movzbq	0x8(%r8), %r12
               	andq	$0x1, %rcx
               	andq	$-0x2, %r12
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	orq	%r11, %rcx
               	orq	$0x1, %r12
               	movq	%rcx, (%r8)
               	movb	%r12b, 0x8(%r8)
               	movzbq	0x8(%r8), %r12
               	shrq	%rcx
               	shlq	$0x3f, %r12
               	orq	%r12, %rcx
               	movabsq	$-0x7edcba9876543211, %r11 # imm = 0x8123456789ABCDEF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movzbq	(%r8), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0x8(%r8), %rcx
               	sarq	%rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	movzbq	(%rdx), %rcx
               	cmpl	$0xab, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%r8), %rcx
               	movzbq	0x8(%r8), %r12
               	movq	%rcx, %r13
               	shrq	%r13
               	movq	%r12, %r14
               	shlq	$0x3f, %r14
               	orq	%r14, %r13
               	cmpq	$-0x3, %r13
               	setae	%r13b
               	movzbq	%r13b, %r13
               	shlq	%r13
               	andq	$0x1, %rcx
               	andq	$-0x2, %r12
               	orq	%r13, %rcx
               	movq	%rcx, (%r8)
               	movb	%r12b, 0x8(%r8)
               	movzbq	0x8(%r8), %r12
               	shrq	%rcx
               	shlq	$0x3f, %r12
               	orq	%r12, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%r8), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0x8(%r8), %rcx
               	sarq	%rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	movzbq	(%rdx), %rcx
               	cmpl	$0xaa, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi)
               	movb	%cl, (%r9)
               	movb	%cl, (%rbx)
               	leaq	-0x1d(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x1c(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x1b(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x1a(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x19(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x18(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x17(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x16(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x15(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x14(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x13(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x12(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x11(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x10(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0xf(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0xe(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0xd(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0xc(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0xb(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0xa(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x9(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x8(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x7(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x6(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x5(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x4(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x3(%rax), %rdx
               	movb	%cl, (%rdx)
               	leaq	-0x2(%rax), %rdx
               	movb	%cl, (%rdx)
               	decq	%rax
               	movb	%cl, (%rax)
               	movzbq	(%rsi), %rdx
               	andq	$-0x2, %rdx
               	orq	$0x1, %rdx
               	movb	%dl, (%rsi)
               	movzbq	0x10(%rsi), %rdx
               	andq	$-0xff, %rdx
               	orq	$0x54, %rdx
               	movb	%dl, 0x10(%rsi)
               	movq	(%rsi), %rdx
               	movzbq	0x10(%rsi), %rdi
               	andq	$0x1, %rdx
               	movabsq	$-0x2468acf13579be0, %r11 # imm = 0xFDB97530ECA86420
               	orq	%r11, %rdx
               	movabsq	$0x2468acf13579bdf, %r8 # imm = 0x2468ACF13579BDF
               	movq	%rdx, (%rsi)
               	movq	%r8, 0x8(%rsi)
               	andq	$-0x2, %rdi
               	movb	%dil, 0x10(%rsi)
               	movzbq	0x10(%rsi), %r8
               	shrq	%rdx
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	orq	%rdx, %rdi
               	shlq	$0x3f, %r8
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	orq	%r11, %r8
               	leaq	0x1(%rdi), %rdx
               	cmpq	%rdi, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	addq	%r8, %rdi
               	movq	%rdx, %r8
               	shlq	%r8
               	movq	%rdi, %r9
               	shlq	%r9
               	shrq	$0x3f, %rdx
               	orq	%rdx, %r9
               	movq	(%rsi), %rdx
               	movzbq	0x10(%rsi), %rbx
               	andq	$0x1, %rdx
               	orq	%r8, %rdx
               	orq	%r9, %rcx
               	movq	%rdx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	shrq	$0x3f, %rdi
               	andq	$-0x2, %rbx
               	orq	%rbx, %rdi
               	movb	%dil, 0x10(%rsi)
               	movzbq	0x10(%rsi), %rdi
               	movq	%rcx, %r8
               	shrq	%r8
               	shrq	%rdx
               	shlq	$0x3f, %rcx
               	orq	%rdx, %rcx
               	shlq	$0x3f, %rdi
               	orq	%r8, %rdi
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	xorq	%rdi, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%rsi), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0x10(%rsi), %rcx
               	sarq	%rcx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movzbq	(%rax), %rcx
               	cmpl	$0x54, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%rsi), %rcx
               	movzbq	0x10(%rsi), %rdx
               	andq	$0x1, %rcx
               	orq	$-0x2, %rcx
               	movq	%rcx, (%rsi)
               	movq	$-0x1, 0x8(%rsi)
               	andq	$-0x2, %rdx
               	orq	$0x1, %rdx
               	movb	%dl, 0x10(%rsi)
               	movzbq	0x10(%rsi), %rdx
               	shrq	%rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	shlq	$0x3f, %rdx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	orq	%r11, %rdx
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%rsi), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0x10(%rsi), %rcx
               	sarq	%rcx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movzbq	(%rax), %rax
               	cmpl	$0x55, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
