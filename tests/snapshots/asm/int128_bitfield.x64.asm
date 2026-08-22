
int128_bitfield.x64:	file format elf64-x86-64

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

<chk>:
               	popq	%r10
               	subq	$0x40, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	movq	%rcx, %rdx
               	movq	%r8, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdi
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movq	0x8(%rax), %rdx
               	cmpq	%rsi, %rdx
               	je	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x3c0, %rsp            # imm = 0x3C0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0x800000000, %rsi      # imm = 0x800000000
               	movl	$0x1234, %edx           # imm = 0x1234
               	movl	$0xa, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	xorq	%rsi, %rsi
               	movl	$0x7, %edx
               	movl	$0xd, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	xorq	%rsi, %rsi
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movl	$0x9, %edx
               	movl	$0x10, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x390(%rbp), %rax
               	movl	$0x5, %edx
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0x800000000, %rbx      # imm = 0x800000000
               	orq	%rcx, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0x800000000, %rsi      # imm = 0x800000000
               	movl	$0x14, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x390(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	$0x7, %edx
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x17, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x380(%rbp), %rax
               	movabsq	$-0x1, %rdx
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	orq	%rcx, %rsi
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movabsq	$-0x1000000000, %rbx    # imm = 0xFFFFFFF000000000
               	orq	%rcx, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	movl	$0x1a, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shrq	$0x24, %rax
               	xorq	%rsi, %rsi
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movl	$0xfffffff, %edx        # imm = 0xFFFFFFF
               	movl	$0x1d, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x380(%rbp), %rax
               	xorq	%rsi, %rsi
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movq	%rcx, %rbx
               	orq	$0x0, %rbx
               	movq	%rsi, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x20, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shrq	$0x24, %rax
               	xorq	%rsi, %rsi
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movl	$0xfffffff, %edx        # imm = 0xFFFFFFF
               	movl	$0x23, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x370(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %rdx # imm = 0xFEDCBA9876543210
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movl	$0x26, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x360(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000000000, %rdx # imm = 0xF000000000000000
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x3000000000, %rbx    # imm = 0xFFFFFFD000000000
               	orq	%rcx, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$-0x1, %rsi
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	shlq	$0x1c, %rax
               	orq	$0xf000000, %rax        # imm = 0xF000000
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movl	$0x29, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	shlq	$0x24, %rax
               	movq	%rax, %rcx
               	sarq	$0x24, %rcx
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x1, %rsi
               	movabsq	$-0x3, %rdx
               	movl	$0x2c, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x360(%rbp), %rax
               	xorq	%rdx, %rdx
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movabsq	$0x800000000, %rbx      # imm = 0x800000000
               	orq	%rcx, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	shlq	$0x1c, %rax
               	orq	$0x0, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$-0x800000000, %rsi     # imm = 0xFFFFFFF800000000
               	movl	$0x2f, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x360(%rbp), %rax
               	xorq	%rdx, %rdx
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	orq	$0x0, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x400000000, %rsi      # imm = 0x400000000
               	movl	$0x32, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x350(%rbp), %rax
               	movl	$0xab, %ecx
               	movb	%cl, (%rax)
               	movl	$0x3, %edx
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	andq	$0xff, %rcx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rsi
               	movq	%rcx, %rdi
               	orq	$0x300, %rdi            # imm = 0x300
               	movq	%rsi, %rcx
               	orq	$0x200000, %rcx         # imm = 0x200000
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x8, %rax
               	shlq	$0x38, %rcx
               	orq	$0x3, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x2000, %esi           # imm = 0x2000
               	movl	$0x35, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x350(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xab, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x340(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x20, %rcx
               	orq	$0x1f, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rsi, %rsi
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	andq	$0x1f, %rcx
               	andq	$-0x2, %rdx
               	orq	$0x160, %rcx            # imm = 0x160
               	orq	$0x1, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	andq	$-0x1fffff, %rdx        # imm = 0xFFE00001
               	movq	%rdx, %rbx
               	orq	$0x1ffffe, %rbx         # imm = 0x1FFFFE
               	movq	%rbx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x5, %rax
               	movq	%rbx, %rcx
               	shlq	$0x3b, %rcx
               	orq	%rcx, %rax
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movabsq	$0x80000000000000b, %rdx # imm = 0x80000000000000B
               	movl	$0x39, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x340(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x1f, %rax
               	cmpq	$0x1f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rax
               	sarq	%rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0xfffff, %rax          # imm = 0xFFFFF
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movl	$0x1, %edx
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdi
               	leaq	0x4000000(%rdi), %rsi
               	leaq	(%rsi), %rdi
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, %rbx
               	orq	%rsi, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r12      # imm = 0xFFFFFFFFF
               	andq	%rbx, %r12
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%r12, 0x8(%rdi)
               	movl	$0x4000000, %esi        # imm = 0x4000000
               	movl	$0x3d, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movl	$0x3, %edx
               	movq	%r12, %rcx
               	imulq	%rdx, %rcx
               	leaq	(%rcx), %rsi
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rsi
               	movq	%rsi, %rbx
               	orq	%rcx, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r12      # imm = 0xFFFFFFFFF
               	andq	%rbx, %r12
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%r12, 0x8(%rdi)
               	movl	$0xc000000, %esi        # imm = 0xC000000
               	movl	$0x40, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	leaq	(%r12), %rcx
               	leaq	(%rcx), %rdx
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rcx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rsi
               	movl	$0x2, %edx
               	movq	%rsi, %rbx
               	orq	%rcx, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r12      # imm = 0xFFFFFFFFF
               	andq	%rbx, %r12
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%r12, 0x8(%rdi)
               	movl	$0xc000000, %esi        # imm = 0xC000000
               	movl	$0x43, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x5, %rcx
               	movq	%rcx, %rdx
               	orq	$0x0, %rdx
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rcx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rsi
               	movl	$0x40, %edx
               	movq	%rsi, %rbx
               	orq	%rcx, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r12      # imm = 0xFFFFFFFFF
               	andq	%rbx, %r12
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%r12, 0x8(%rdi)
               	movabsq	$0x180000000, %rsi      # imm = 0x180000000
               	movl	$0x46, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movq	%r12, %rdx
               	sarq	$0x3, %rdx
               	movq	%r12, %rcx
               	shlq	$0x3d, %rcx
               	movq	%rcx, %rsi
               	orq	$0x8, %rsi
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rcx
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rdx
               	movq	%rsi, %r12
               	orq	$0x0, %r12
               	movq	%rdx, %rbx
               	orq	%rcx, %rbx
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%r12, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x30000000, %esi       # imm = 0x30000000
               	movl	$0x8, %edx
               	movl	$0x49, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rdi
               	movl	$0xff, %edx
               	xorq	%rsi, %rsi
               	movq	%r12, %r8
               	orq	%rdx, %r8
               	orq	%rsi, %rdi
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rcx
               	movabsq	$-0x1000000000, %rdi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rdi
               	movq	%rsi, %r12
               	orq	%r8, %r12
               	movq	%rdi, %rbx
               	orq	%rcx, %rbx
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%r12, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x30000000, %esi       # imm = 0x30000000
               	movl	$0x4c, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rdx
               	movq	%r12, %rsi
               	andq	$-0x10, %rsi
               	andq	$-0x1, %rdx
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rcx
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rdx
               	movq	%rsi, %r12
               	orq	$0x0, %r12
               	movq	%rdx, %rbx
               	orq	%rcx, %rbx
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%r12, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x30000000, %esi       # imm = 0x30000000
               	movl	$0xf0, %edx
               	movl	$0x4f, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rsi
               	xorq	%rdx, %rdx
               	movq	%r12, %rdi
               	xorq	$0x55, %rdi
               	xorq	%rdx, %rsi
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rsi
               	movq	%rdx, %rbx
               	orq	%rdi, %rbx
               	movq	%rsi, %r15
               	orq	%rcx, %r15
               	movq	%rbx, (%rax)
               	movq	%r15, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%r15, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rbx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x30000000, %esi       # imm = 0x30000000
               	movl	$0xa5, %edx
               	movl	$0x52, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %r14
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%r15, %rcx
               	xorq	%r13, %r13
               	movq	%rbx, %rax
               	xorq	%r13, %rax
               	xorq	%r13, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rax
               	subq	%rdx, %rax
               	movl	$0x7, %r9d
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rax, %r8
               	shrq	$0x3f, %r8
               	movq	%rsi, %rbx
               	shlq	%rbx
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	movq	%rbx, %rsi
               	orq	%r8, %rsi
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	testq	%rcx, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rcx, %rcx
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x7, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r8, %r8
               	subq	%rdi, %r8
               	andq	%r9, %r8
               	cmpq	%r8, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r8, %rsi
               	subq	$0x0, %rcx
               	subq	%r12, %rcx
               	orq	%rbx, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %rax
               	testq	%rdi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	$0x0, %rdi
               	subq	$0x0, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%r15, %rcx
               	movq	%rdi, %rbx
               	orq	$0x0, %rbx
               	movq	%rcx, %r15
               	orq	%rax, %r15
               	movq	%rbx, (%r14)
               	movq	%r15, 0x8(%r14)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%r15, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rbx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x6db6db6, %esi        # imm = 0x6DB6DB6
               	movabsq	$-0x249249249249247b, %rdx # imm = 0xDB6DB6DB6DB6DB85
               	movl	$0x55, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %r14
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%r15, %rcx
               	xorq	%r13, %r13
               	movq	%rbx, %rax
               	xorq	%r13, %rax
               	xorq	%r13, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rax
               	subq	%rdx, %rax
               	movl	$0xf4243, %r8d          # imm = 0xF4243
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rax, %r9
               	shrq	$0x3f, %r9
               	movq	%rsi, %rbx
               	shlq	%rbx
               	shlq	%rcx
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rcx
               	movq	%rbx, %rsi
               	orq	%r9, %rsi
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	testq	%rcx, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rcx, %rcx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r9
               	orq	%r9, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r9, %r9
               	subq	%rdi, %r9
               	andq	%r8, %r9
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r9, %rsi
               	subq	$0x0, %rcx
               	subq	%r12, %rcx
               	orq	%rbx, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rax
               	xorq	%r13, %rax
               	xorq	%r13, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rax), %rdi
               	leaq	(%rcx), %rax
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	xorq	%rsi, %rsi
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%r15, %rdx
               	movq	%rsi, %rcx
               	orq	%rdi, %rcx
               	movq	%rdx, %rbx
               	orq	%rax, %rbx
               	movq	%rcx, (%r14)
               	movq	%rbx, 0x8(%r14)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x247c3, %edx          # imm = 0x247C3
               	movl	$0x58, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	xorq	%rsi, %rsi
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movabsq	$-0x1, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	addq	$0x0, %rdx
               	incq	%rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rsi, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x5b, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	xorq	%rdx, %rdx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	movabsq	$-0x1, %rdx
               	decq	%rsi
               	addq	$0x0, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, %rbx
               	orq	%rsi, %rbx
               	movq	%rdx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	movl	$0x5e, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	movl	$0x5, %edx
               	xorq	%r8, %r8
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	addq	$0x0, %rsi
               	addq	$0x0, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x6, %r12d
               	movq	%rcx, %rbx
               	orq	%rsi, %rbx
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movl	$0x61, %ecx
               	xchgq	%r8, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%r12, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	xorq	%rsi, %rsi
               	movl	$0x6, %edx
               	movl	$0x64, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x330(%rbp), %rax
               	xorq	%r8, %r8
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movl	$0x5, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	movl	$0x6, %edx
               	addq	$0x0, %rsi
               	addq	$0x0, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rsi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movl	$0x67, %ecx
               	xchgq	%r8, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x320(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rdx
               	xorq	%rcx, %rcx
               	orq	$0x0, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$0x3e8000000000, %r11   # imm = 0x3E8000000000
               	orq	%r11, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdx, %rdi
               	shrq	$0x24, %rdi
               	movq	%rdi, %r8
               	andq	$0xfffffff, %r8         # imm = 0xFFFFFFF
               	cmpq	$0x3e8, %r8             # imm = 0x3E8
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x6b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	0x7(%r8), %rsi
               	andq	$0xfffffff, %rsi        # imm = 0xFFFFFFF
               	shlq	$0x24, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	orq	%rsi, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x3ef, %rax            # imm = 0x3EF
               	je	<addr>
               	movl	$0x6c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x320(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	xorq	%rcx, %rcx
               	movabsq	$0x3f0000000000, %r11   # imm = 0x3F0000000000
               	orq	%r11, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x3f0, %rax            # imm = 0x3F0
               	je	<addr>
               	movl	$0x6d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	leaq	-0x310(%rbp), %rax
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	orq	$0x0, %rsi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x5000000000, %r11    # imm = 0xFFFFFFB000000000
               	orq	%r11, %rsi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	shlq	$0x24, %rax
               	movq	%rax, %rdi
               	sarq	$0x24, %rdi
               	cmpq	$-0x5, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	xorq	%rsi, %rsi
               	movl	$0x6f, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	movl	$0x99, %edx
               	movl	$0x10000, %esi          # imm = 0x10000
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movl	$0x72, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	$0x123, %edx            # imm = 0x123
               	leaq	-0x2d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	movl	$0x75, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x3c0, %rsp            # imm = 0x3C0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%r13, %rcx
               	movq	%r13, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movq	%r13, %rcx
               	movq	%r13, %rax
               	jmp	<addr>
               	jmp	<addr>
