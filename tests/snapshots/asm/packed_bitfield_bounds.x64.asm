
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

<page_end>:
               	pushq	%rbp
               	movq	%rsp, %rbp
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
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	(%r12,%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x3(%r13), %r12
               	leaq	-0x5(%r13), %r14
               	leaq	-0x6(%r13), %r15
               	leaq	-0x7(%r13), %rbx
               	leaq	-0x10(%r13), %rdi
               	movl	$0xff, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	andq	$-0x400000, %rax        # imm = 0xFFC00000
               	orq	$0x3ffffb, %rax         # imm = 0x3FFFFB
               	movw	%ax, (%r12)
               	shrq	$0x10, %rax
               	movb	%al, 0x2(%r12)
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	andq	$0x3fffff, %rax         # imm = 0x3FFFFF
               	shlq	$0x2a, %rax
               	sarq	$0x2a, %rax
               	addq	$0x7, %rax
               	andq	$0x3fffff, %rax         # imm = 0x3FFFFF
               	movzwq	(%r12), %rcx
               	movzbq	0x2(%r12), %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	andq	$-0x400000, %rcx        # imm = 0xFFC00000
               	orq	%rcx, %rax
               	movw	%ax, (%r12)
               	shrq	$0x10, %rax
               	movb	%al, 0x2(%r12)
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	andq	$0x3fffff, %rax         # imm = 0x3FFFFF
               	shlq	$0x2a, %rax
               	sarq	$0x2a, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	-0x1(%r13), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xc0, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x10(%r13), %rdi
               	movl	$0xff, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%r14), %eax
               	movzbq	0x4(%r14), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$0xedcba9877, %r11      # imm = 0xEDCBA9877
               	orq	%r11, %rax
               	movl	%eax, (%r14)
               	shrq	$0x20, %rax
               	movb	%al, 0x4(%r14)
               	movl	(%r14), %eax
               	movzbq	0x4(%r14), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1c, %rax
               	sarq	$0x1c, %rax
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	-0x1(%r13), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xfe, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	(%r14), %ecx
               	movzbq	0x4(%r14), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	$0x5, %rcx
               	movl	%ecx, (%r14)
               	shrq	$0x20, %rcx
               	movb	%cl, 0x4(%r14)
               	movl	(%r14), %ecx
               	movzbq	0x4(%r14), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x1c, %rcx
               	sarq	$0x1c, %rcx
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	movzbq	(%rax), %rax
               	xorq	$0xf0, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x10(%r13), %rdi
               	movl	$0xff, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%r15), %eax
               	movzwq	0x4(%r15), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rax
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	orq	%r11, %rax
               	movl	%eax, (%r15)
               	shrq	$0x20, %rax
               	movw	%ax, 0x4(%r15)
               	movl	(%r15), %eax
               	movzwq	0x4(%r15), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x14, %rax
               	sarq	$0x14, %rax
               	decq	%rax
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rax
               	movl	(%r15), %ecx
               	movzwq	0x4(%r15), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rcx
               	orq	%rcx, %rax
               	movl	%eax, (%r15)
               	shrq	$0x20, %rax
               	movw	%ax, 0x4(%r15)
               	movl	(%r15), %eax
               	movzwq	0x4(%r15), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x14, %rax
               	sarq	$0x14, %rax
               	movabsq	$0x7fffffffffe, %r11    # imm = 0x7FFFFFFFFFE
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	-0x1(%r13), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xf7, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x10(%r13), %rdi
               	movl	$0xff, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rbx), %eax
               	movzwq	0x4(%rbx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movzbq	0x6(%rbx), %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rax
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	orq	%r11, %rax
               	movl	%eax, (%rbx)
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	movw	%cx, 0x4(%rbx)
               	shrq	$0x30, %rax
               	movb	%al, 0x6(%rbx)
               	movl	(%rbx), %eax
               	movzwq	0x4(%rbx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movzbq	0x6(%rbx), %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0xc, %rax
               	sarq	$0xc, %rax
               	xorq	$0x5, %rax
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movl	(%rbx), %ecx
               	movzwq	0x4(%rbx), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movzbq	0x6(%rbx), %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rcx
               	orq	%rcx, %rax
               	movl	%eax, (%rbx)
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	movw	%cx, 0x4(%rbx)
               	shrq	$0x30, %rax
               	movb	%al, 0x6(%rbx)
               	movl	(%rbx), %eax
               	movzwq	0x4(%rbx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movzbq	0x6(%rbx), %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0xc, %rax
               	sarq	$0xc, %rax
               	cmpq	$-0x6, %rax
               	jne	<addr>
               	leaq	-0x1(%r13), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	(%rbx), %eax
               	movzwq	0x4(%rbx), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movzbq	0x6(%rbx), %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rax
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rax
               	movl	%eax, (%rbx)
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	movw	%dx, 0x4(%rbx)
               	shrq	$0x30, %rax
               	movb	%al, 0x6(%rbx)
               	movl	(%rbx), %eax
               	movzwq	0x4(%rbx), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movzbq	0x6(%rbx), %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rax
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0xc, %rax
               	sarq	$0xc, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	xorq	$0xf0, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x10(%r13), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	(%r12), %rax
               	andq	$-0x10, %rax
               	orq	$0x9, %rax
               	movb	%al, (%r12)
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	orq	$0xedcbb0, %rax         # imm = 0xEDCBB0
               	movw	%ax, (%r12)
               	shrq	$0x10, %rax
               	movb	%al, 0x2(%r12)
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	sarq	$0x4, %rax
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$0xfffedcbb, %eax       # imm = 0xFFFEDCBB
               	jne	<addr>
               	movzbq	(%r12), %rax
               	andq	$0xf, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x10, %rdx
               	orq	%rax, %rdx
               	sarq	$0x4, %rdx
               	shlq	$0x2c, %rdx
               	sarq	$0x2c, %rdx
               	incq	%rdx
               	andq	$0xfffff, %rdx          # imm = 0xFFFFF
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	orq	%rcx, %rax
               	movw	%ax, (%r12)
               	shrq	$0x10, %rax
               	movb	%al, 0x2(%r12)
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	sarq	$0x4, %rax
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$0xfffedcbc, %eax       # imm = 0xFFFEDCBC
               	jne	<addr>
               	movzbq	(%r12), %rax
               	andq	$0xf, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x10(%r13), %rdi
               	movl	$0xff, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	andq	$-0x800000, %rax        # imm = 0xFF800000
               	orq	$0x2aaaaa, %rax         # imm = 0x2AAAAA
               	movw	%ax, (%r12)
               	shrq	$0x10, %rax
               	movb	%al, 0x2(%r12)
               	movzwq	(%r12), %rax
               	movzbq	0x2(%r12), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	cmpl	$0x2aaaaa, %eax         # imm = 0x2AAAAA
               	jne	<addr>
               	leaq	-0x1(%r13), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xaa, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x10(%r13), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movb	$0x5a, (%rbx)
               	movl	0x1(%rbx), %eax
               	movzwq	0x5(%rbx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rax
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	orq	%r11, %rax
               	movl	%eax, 0x1(%rbx)
               	shrq	$0x20, %rax
               	movw	%ax, 0x5(%rbx)
               	movl	0x1(%rbx), %eax
               	movzwq	0x5(%rbx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	-0x1(%r13), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xfe, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	0x1(%rbx), %eax
               	movzwq	0x5(%rbx), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x20, %rdx
               	orq	%rax, %rdx
               	shrq	$0x4, %rdx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rax
               	orq	%rdx, %rax
               	movl	%eax, 0x1(%rbx)
               	shrq	$0x20, %rax
               	movw	%ax, 0x5(%rbx)
               	movl	0x1(%rbx), %eax
               	movzwq	0x5(%rbx), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfedcba98765, %r11    # imm = 0xFEDCBA98765
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
