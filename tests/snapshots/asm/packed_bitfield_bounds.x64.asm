
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
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x3(%r14), %r12
               	leaq	-0x5(%r14), %r15
               	leaq	-0x6(%r14), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	-0x7(%r14), %rbx
               	leaq	-0xe(%r14), %r13
               	leaq	-0x10(%r14), %rdi
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
               	leaq	-0x1(%r14), %rax
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
               	leaq	-0x10(%r14), %rdi
               	movl	$0xff, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%r15), %eax
               	movzbq	0x4(%r15), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$0xedcba9877, %r11      # imm = 0xEDCBA9877
               	orq	%r11, %rax
               	movl	%eax, (%r15)
               	shrq	$0x20, %rax
               	movb	%al, 0x4(%r15)
               	movl	(%r15), %eax
               	movzbq	0x4(%r15), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1c, %rax
               	sarq	$0x1c, %rax
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	-0x1(%r14), %rax
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
               	movl	(%r15), %ecx
               	movzbq	0x4(%r15), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	$0x5, %rcx
               	movl	%ecx, (%r15)
               	shrq	$0x20, %rcx
               	movb	%cl, 0x4(%r15)
               	movl	(%r15), %ecx
               	movzbq	0x4(%r15), %rdx
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
               	leaq	-0x10(%r14), %rdi
               	movl	$0xff, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x38(%rsp), %rax
               	movl	(%rax), %ecx
               	movzwq	0x4(%rax), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rcx
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	orq	%r11, %rcx
               	movl	%ecx, (%rax)
               	shrq	$0x20, %rcx
               	movw	%cx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movzwq	0x4(%rax), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x14, %rcx
               	sarq	$0x14, %rcx
               	decq	%rcx
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rcx
               	movl	(%rax), %edx
               	movzwq	0x4(%rax), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	shrq	$0x20, %rcx
               	movw	%cx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movzwq	0x4(%rax), %rax
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x14, %rax
               	sarq	$0x14, %rax
               	movabsq	$0x7fffffffffe, %r11    # imm = 0x7FFFFFFFFFE
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	-0x1(%r14), %rax
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
               	leaq	-0x10(%r14), %rdi
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
               	leaq	-0x1(%r14), %rcx
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
               	leaq	-0x10(%r14), %rdi
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
               	leaq	-0x10(%r14), %rdi
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
               	leaq	-0x1(%r14), %rax
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
               	leaq	-0x10(%r14), %rdi
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
               	leaq	-0x1(%r14), %rax
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
               	leaq	-0x20(%r14), %rdi
               	movl	$0xff, %esi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movb	$0x3, (%r13)
               	movl	0x9(%r13), %eax
               	movzbq	0xd(%r13), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$-0x123456789abcdf0, %rcx # imm = 0xFEDCBA9876543210
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	orq	%r11, %rax
               	movq	%rcx, 0x1(%r13)
               	movl	%eax, 0x9(%r13)
               	shrq	$0x20, %rax
               	movb	%al, 0xd(%r13)
               	movl	0x9(%r13), %eax
               	movzbq	0xd(%r13), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1c, %rax
               	orq	$0xfedcba9, %rax        # imm = 0xFEDCBA9
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	movabsq	$0x876543210, %r11      # imm = 0x876543210
               	orq	%r11, %rax
               	leaq	0x1(%rax), %rcx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movl	0x9(%r13), %edx
               	movzbq	0xd(%r13), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, 0x1(%r13)
               	movl	%eax, 0x9(%r13)
               	shrq	$0x20, %rax
               	movb	%al, 0xd(%r13)
               	movq	0x1(%r13), %rax
               	movl	0x9(%r13), %ecx
               	movzbq	0xd(%r13), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rax, %rdx
               	shlq	$0x1c, %rdx
               	shlq	$0x1c, %rcx
               	shrq	$0x24, %rax
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shrq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	orq	%rdx, %rax
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rax
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	xorq	%r11, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x1(%r14), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0xf1, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	$-0x2, %rcx
               	movl	0x9(%r13), %edx
               	movzbq	0xd(%r13), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rdx
               	movq	%rcx, 0x1(%r13)
               	movl	%edx, 0x9(%r13)
               	shrq	$0x20, %rdx
               	movb	%dl, 0xd(%r13)
               	movl	0x9(%r13), %edx
               	movzbq	0xd(%r13), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x1c, %rdx
               	orq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	movq	%rdx, %rsi
               	sarq	$0x1c, %rsi
               	shlq	$0x24, %rdx
               	movabsq	$0xffffffffe, %r11      # imm = 0xFFFFFFFFE
               	orq	%r11, %rdx
               	xorq	%rdx, %rcx
               	movq	%rsi, %rdx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%rax), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
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
