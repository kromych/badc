
int128_bitfield.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	movq	(%rax), %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
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
               	subq	$0xa60, %rsp            # imm = 0xA60
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
               	leaq	-0x590(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x5a0(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	xorq	%rsi, %rsi
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	-0x5b0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9b0(%rbp), %rax
               	movl	$0x5, %edx
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rsi
               	movl	$0x5, %ecx
               	movabsq	$0x800000000, %rbx      # imm = 0x800000000
               	orq	%rsi, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x610(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9b0(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	$0x7, %r8d
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rdx
               	movl	$0x7, %ecx
               	orq	$0x0, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	leaq	-0x670(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x17, %ecx
               	movq	%rsi, %rdx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9c0(%rbp), %rax
               	movabsq	$-0x1, %rsi
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x1, %rdi
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	orq	%rcx, %rdx
               	movq	%rdi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x9c0(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x1000000000, %rbx    # imm = 0xFFFFFFF000000000
               	orq	%rdx, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x6e0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	movl	$0x1a, %ecx
               	movq	%rax, %rdx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shrq	$0x24, %rax
               	xorq	%rsi, %rsi
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	-0x6f0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9c0(%rbp), %rax
               	xorq	%rsi, %rsi
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rdx
               	xorq	%rcx, %rcx
               	movq	%rdx, %rbx
               	orq	$0x0, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x720(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shrq	$0x24, %rax
               	xorq	%rsi, %rsi
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	-0x730(%rbp), %rdi
               	movq	%rax, (%rdi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9d0(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %r8 # imm = 0xFEDCBA9876543210
               	movabsq	$-0x123456789abcdf0, %rcx # imm = 0xFEDCBA9876543210
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x790(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movl	$0x26, %ecx
               	movq	%rsi, %rdx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9e0(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000000000, %rdx # imm = 0xF000000000000000
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9e0(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000000000, %rdx # imm = 0xF000000000000000
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
               	leaq	-0x7f0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$-0x1000000000000000, %rdx # imm = 0xF000000000000000
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	shlq	$0x24, %rax
               	movq	%rax, %rcx
               	sarq	$0x24, %rcx
               	leaq	-0x800(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9e0(%rbp), %rax
               	xorq	%rdx, %rdx
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	xorq	%rsi, %rsi
               	movabsq	$0x800000000, %rbx      # imm = 0x800000000
               	orq	%rcx, %rbx
               	movq	%rsi, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	shlq	$0x1c, %rax
               	orq	$0x0, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	leaq	-0x850(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9e0(%rbp), %rax
               	xorq	%rdx, %rdx
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	xorq	%rsi, %rsi
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	orq	%r11, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	orq	$0x0, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	leaq	-0x8a0(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9f0(%rbp), %rax
               	movl	$0xab, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x9f0(%rbp), %rax
               	movl	$0x3, %esi
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rcx
               	movabsq	$-0x100000000000, %rdi  # imm = 0xFFFFF00000000000
               	andq	%rdx, %rdi
               	movq	%rcx, %rdx
               	orq	$0x300, %rdx            # imm = 0x300
               	movq	%rdi, %rcx
               	orq	$0x200000, %rcx         # imm = 0x200000
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x8, %rax
               	shrq	$0x8, %rdx
               	shlq	$0x38, %rcx
               	orq	%rdx, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x900(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x2000, %eax           # imm = 0x2000
               	movl	$0x35, %ecx
               	movq	%rax, %rdx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9f0(%rbp), %rax
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa00(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x20, %rcx
               	orq	$0x1f, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0xa00(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	andq	$0x1f, %rcx
               	andq	$-0x2, %rdx
               	orq	$0x160, %rcx            # imm = 0x160
               	orq	$0x1, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xa00(%rbp), %rax
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
               	leaq	-0x960(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa00(%rbp), %rax
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movl	$0x1, %esi
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x1, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdi
               	leaq	0x4000000(%rdi), %rdx
               	leaq	(%rdx), %rdi
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rdx
               	movabsq	$-0x1000000000, %rdi    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rdi
               	movl	$0x1, %ecx
               	movq	%rdi, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x320(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x4000000, %eax        # imm = 0x4000000
               	movl	$0x3d, %ecx
               	movq	%rax, %rdx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rsi
               	movl	$0x3, %edx
               	movq	%rsi, %rcx
               	imulq	%rdx, %rcx
               	leaq	(%rcx), %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %rdi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rdi
               	movl	$0x3, %ecx
               	movq	%rdi, %rbx
               	orq	%rsi, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x370(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rdx
               	leaq	(%rdx), %rcx
               	leaq	(%rcx), %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rsi
               	movl	$0x2, %ecx
               	movq	%rsi, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x3c0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0xc000000, %esi        # imm = 0xC000000
               	movl	$0x2, %edx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x5, %rcx
               	movq	%rcx, %rdx
               	orq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rsi
               	movl	$0x40, %ecx
               	movq	%rsi, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x410(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0x180000000, %rsi      # imm = 0x180000000
               	movl	$0x40, %edx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x3d, %rcx
               	movq	%rcx, %rdx
               	orq	$0x8, %rdx
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rsi
               	movq	%rdx, %r12
               	orq	$0x0, %r12
               	movq	%rsi, %rbx
               	orq	%rcx, %rbx
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x460(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
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
               	leaq	-0x4b0(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
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
               	leaq	-0x520(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
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
               	movq	%rsi, %r10
               	orq	%rcx, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%rbx, (%rax)
               	movq	0x30(%rsp), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x30(%rsp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x570(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x30(%rsp), %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rcx, %r12
               	sarq	$0x3f, %r12
               	movq	%rbx, %rax
               	xorq	%r12, %rax
               	xorq	%r12, %rcx
               	cmpq	%r12, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	subq	%r12, %rsi
               	movq	%rcx, %rax
               	subq	%r12, %rax
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movl	$0x7, %ebx
               	xorq	%r13, %r13
               	movq	%rcx, %rax
               	orq	%r13, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r8
               	shrq	$0x3f, %r8
               	movq	%rsi, %r9
               	shlq	%r9
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%r9, %rsi
               	orq	%r8, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x7, %rsi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r8, %r8
               	subq	%rdi, %r8
               	movq	%rbx, %r9
               	andq	%r8, %r9
               	andq	%r13, %r8
               	cmpq	%r9, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%r9, %rsi
               	subq	%r8, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%r12, %rdx
               	xorq	$0x0, %rdx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %rcx
               	cmpq	%rdx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rdx, %rdi
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	subq	%r8, %rdx
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	movq	0x30(%rsp), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rdi, %rbx
               	orq	$0x0, %rbx
               	movq	%rcx, %r10
               	orq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%rbx, (%r10)
               	movq	0x38(%rsp), %r10
               	movq	0x30(%rsp), %r11
               	movq	%r11, 0x8(%r10)
               	movq	0x30(%rsp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x280(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x30(%rsp), %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rcx, %r12
               	sarq	$0x3f, %r12
               	movq	%rbx, %rax
               	xorq	%r12, %rax
               	xorq	%r12, %rcx
               	cmpq	%r12, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	subq	%r12, %rsi
               	movq	%rcx, %rax
               	subq	%r12, %rax
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movl	$0xf4243, %r8d          # imm = 0xF4243
               	xorq	%r13, %r13
               	movq	%rcx, %rax
               	orq	%r13, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rsi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%rbx, %rsi
               	orq	%r9, %rsi
               	movq	%rdi, %r14
               	shlq	%r14
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r9, %r9
               	subq	%rdi, %r9
               	movq	%r8, %rbx
               	andq	%r9, %rbx
               	andq	%r13, %r9
               	cmpq	%rbx, %rsi
               	setb	%r15b
               	movzbq	%r15b, %r15
               	subq	%rbx, %rsi
               	subq	%r9, %rax
               	subq	%r15, %rax
               	orq	%r14, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rcx
               	xorq	%r12, %rcx
               	xorq	%r12, %rax
               	cmpq	%r12, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%r12, %rcx
               	subq	%r12, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	xorq	%rsi, %rsi
               	movq	0x30(%rsp), %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	orq	%rsi, %rcx
               	movq	%rdx, %rbx
               	orq	%rax, %rbx
               	movq	0x38(%rsp), %r10
               	movq	%rcx, (%r10)
               	movq	0x38(%rsp), %r10
               	movq	%rbx, 0x8(%r10)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0xf0(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	xorq	%rsi, %rsi
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movabsq	$-0x1, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	addq	$0x0, %rdx
               	incq	%rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %rdi    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rdi
               	xorq	%rcx, %rcx
               	movq	%rdi, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x160(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	xorq	%rdx, %rdx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	movabsq	$-0x1, %rsi
               	decq	%rdx
               	addq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %rdi    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rdi
               	movabsq	$-0x1, %rcx
               	movq	%rdi, %rbx
               	orq	%rdx, %rbx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x1a0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	movl	$0x5e, %ecx
               	movq	%rax, %rdx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movl	$0x5, %r8d
               	xorq	%r9, %r9
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movl	$0x5, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	leaq	-0x1d0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	leaq	(%rsi), %rdx
               	addq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x6, %r12d
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%r12, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movl	$0x61, %ecx
               	movq	%r9, %rdx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rbx, %rax
               	leaq	-0x1f0(%rbp), %rdi
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	xorq	%rsi, %rsi
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rbx, %rcx
               	movl	$0x5, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	movl	$0x6, %r8d
               	addq	$0x0, %rdx
               	addq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x6, %edi
               	orq	%rdx, %rcx
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x220(%rbp), %rdi
               	movq	%r8, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movl	$0x6, %edx
               	movl	$0x67, %ecx
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9a0(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9a0(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	movabsq	$0x3e8000000000, %r11   # imm = 0x3E8000000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rax
               	cmpq	$0xbb8, %rax            # imm = 0xBB8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9a0(%rbp), %rax
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	addq	$0x7, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	xorq	%rsi, %rsi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9a0(%rbp), %rax
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	incq	%rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	xorq	%rsi, %rsi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x970(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	xorq	%rdi, %rdi
               	orq	$0x0, %rdx
               	movq	%rdi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x970(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	xorq	%rdi, %rdi
               	movabsq	$-0x5000000000, %r11    # imm = 0xFFFFFFB000000000
               	orq	%r11, %rdx
               	movq	%rdi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdx, %rax
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, (%rdi)
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	movl	$0x99, %edx
               	leaq	-0x990(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x990(%rbp), %rcx
               	movl	$0x99, %eax
               	movl	$0x10000, %esi          # imm = 0x10000
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x990(%rbp), %rax
               	movl	$0x99, %ecx
               	movabsq	$0x123000010000, %rsi   # imm = 0x123000010000
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x10000, %eax          # imm = 0x10000
               	leaq	-0x80(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x10000, %esi          # imm = 0x10000
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	$0x123, %eax            # imm = 0x123
               	leaq	-0x90(%rbp), %rdi
               	movq	%rax, (%rdi)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rdi)
               	movl	$0x123, %edx            # imm = 0x123
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
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
