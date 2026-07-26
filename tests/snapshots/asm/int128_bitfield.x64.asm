
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
               	xorq	%rdi, %rdi
               	leaq	-0x20(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdi, 0x8(%rax)
               	cmpq	%rsi, %rdx
               	je	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9b0(%rbp), %rax
               	movl	$0x1, %esi
               	leaq	-0x5c0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	%rsi, %rdi
               	shlq	$0x23, %rdi
               	leaq	-0x5d0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movl	$0x5, %r8d
               	movq	%rdx, %rsi
               	orq	%r8, %rsi
               	orq	%rdx, %rdi
               	leaq	-0x5e0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x5f0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	orq	%rsi, %rdx
               	orq	%rcx, %rdi
               	movq	%rdx, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x600(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9b0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x610(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0x800000000, %rsi      # imm = 0x800000000
               	movl	$0x14, %ecx
               	movq	%rsi, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9b0(%rbp), %rax
               	movl	$0x1, %edx
               	leaq	-0x620(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdx, %rdi
               	shlq	$0x24, %rdi
               	leaq	-0x630(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movl	$0x7, %r8d
               	movq	%rsi, %rdx
               	orq	%r8, %rdx
               	orq	%rsi, %rdi
               	leaq	-0x640(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x650(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rsi, %r9
               	orq	%rdx, %r9
               	orq	%rcx, %rdi
               	movq	%r9, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x660(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9b0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9c0(%rbp), %rcx
               	xorq	%rax, %rax
               	leaq	-0x680(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movabsq	$-0x1, %r8
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	leaq	-0x690(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	%rdi, 0x8(%rdx)
               	leaq	-0x6a0(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	%rdi, 0x8(%rdx)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rdx
               	movq	0x8(%rcx), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rax, %r9
               	orq	%rsi, %r9
               	orq	%rdx, %rdi
               	movq	%r9, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x6b0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x9c0(%rbp), %rcx
               	leaq	-0x6c0(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	leaq	-0x6d0(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	%rdi, 0x8(%rdx)
               	movq	%rsi, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rdx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rdi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdi
               	orq	%rsi, %rax
               	orq	%rdi, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x9c0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x6e0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	movl	$0x1a, %ecx
               	movq	%rsi, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9c0(%rbp), %rax
               	movq	0x8(%rax), %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	leaq	-0x700(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	movq	%rsi, %rdi
               	orq	%rsi, %rdi
               	orq	%rcx, %rdx
               	movq	%rdi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x710(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9c0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9c0(%rbp), %rax
               	movq	0x8(%rax), %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9d0(%rbp), %rcx
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	leaq	-0x740(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rdx)
               	leaq	-0x750(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movabsq	$-0x123456789abcdf0, %r9 # imm = 0xFEDCBA9876543210
               	movq	%rax, %rdi
               	orq	%r9, %rdi
               	movq	%rsi, %r8
               	orq	%rax, %r8
               	leaq	-0x760(%rbp), %rdx
               	movq	%rdi, (%rdx)
               	movq	%r8, 0x8(%rdx)
               	leaq	-0x770(%rbp), %rdx
               	movq	%rdi, (%rdx)
               	movq	%r8, 0x8(%rdx)
               	movq	%rax, %rdx
               	orq	%rdi, %rdx
               	orq	%r8, %rax
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x780(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%r8, 0x8(%rax)
               	leaq	-0x9d0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	leaq	-0x790(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x26, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%r9, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9e0(%rbp), %rcx
               	movl	$0x1, %esi
               	leaq	-0x7a0(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rdx)
               	movq	%rsi, %rdi
               	shlq	$0x3c, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3c, %rdx
               	shrq	$0x4, %rsi
               	orq	%rdx, %rsi
               	leaq	-0x7b0(%rbp), %rdx
               	movq	%rdi, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	testq	%rdi, %rdi
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rax, %rdx
               	subq	%rdi, %rdx
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %rdi
               	subq	%r8, %rdi
               	leaq	-0x7c0(%rbp), %rsi
               	movq	%rdx, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	leaq	-0x7d0(%rbp), %rsi
               	movq	%rdx, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rsi
               	movq	0x8(%rcx), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rax, %r8
               	orq	%rdx, %r8
               	orq	%rsi, %rdi
               	movq	%r8, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movq	%rdx, %rdi
               	shlq	$0x1c, %rdi
               	movq	%rsi, %rcx
               	shlq	$0x1c, %rcx
               	shrq	$0x24, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x1c, %rdx
               	movq	%rdi, %rsi
               	shrq	$0x1c, %rsi
               	shlq	$0x24, %rcx
               	orq	%rcx, %rsi
               	leaq	-0x7e0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x9e0(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	orq	%rdx, %rax
               	movabsq	$-0x3000000000, %rdx    # imm = 0xFFFFFFD000000000
               	orq	%rsi, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movabsq	$-0x1, %rsi
               	leaq	-0x9e0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movq	%rcx, %rdx
               	shlq	$0x1c, %rdx
               	shlq	$0x1c, %rax
               	shrq	$0x24, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shrq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	orq	%rdx, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9e0(%rbp), %rax
               	movq	0x8(%rax), %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9e0(%rbp), %rax
               	movl	$0x1, %esi
               	leaq	-0x810(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	shlq	$0x23, %rsi
               	leaq	-0x820(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x830(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rdx, %rdi
               	orq	%rdx, %rdi
               	orq	%rcx, %rsi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdx, %rsi
               	shlq	$0x1c, %rsi
               	movq	%rcx, %rax
               	shlq	$0x1c, %rax
               	movq	%rdx, %rcx
               	shrq	$0x24, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shrq	$0x1c, %rsi
               	shlq	$0x24, %rax
               	orq	%rax, %rsi
               	leaq	-0x840(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9e0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movq	%rcx, %rsi
               	shlq	$0x1c, %rsi
               	shlq	$0x1c, %rax
               	shrq	$0x24, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shrq	$0x1c, %rsi
               	shlq	$0x24, %rax
               	orq	%rsi, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9e0(%rbp), %rax
               	movl	$0x1, %esi
               	leaq	-0x860(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	shlq	$0x22, %rsi
               	leaq	-0x870(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x880(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rdx, %rdi
               	orq	%rdx, %rdi
               	orq	%rcx, %rsi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rdx, %rsi
               	shlq	$0x1c, %rsi
               	movq	%rcx, %rax
               	shlq	$0x1c, %rax
               	movq	%rdx, %rcx
               	shrq	$0x24, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shrq	$0x1c, %rsi
               	shlq	$0x24, %rax
               	orq	%rax, %rsi
               	leaq	-0x890(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9e0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movq	%rcx, %rsi
               	shlq	$0x1c, %rsi
               	shlq	$0x1c, %rax
               	shrq	$0x24, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shrq	$0x1c, %rsi
               	shlq	$0x24, %rax
               	orq	%rsi, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	movl	$0x1, %esi
               	leaq	-0x8b0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	shlq	$0xd, %rsi
               	leaq	-0x8c0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movl	$0x3, %r8d
               	movq	%rdx, %rcx
               	orq	%r8, %rcx
               	orq	%rdx, %rsi
               	leaq	-0x8d0(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	leaq	-0x8e0(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x8, %rsi
               	movq	%rdx, %rdi
               	shlq	$0x8, %rdi
               	movq	%rcx, %r9
               	shrq	$0x38, %r9
               	orq	%r9, %rdi
               	movq	(%rax), %r9
               	movq	0x8(%rax), %rbx
               	andq	$0xff, %r9
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rbx
               	orq	%r9, %rsi
               	orq	%rbx, %rdi
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x8f0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x9f0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	shrq	$0x8, %rcx
               	shlq	$0x38, %rax
               	orq	%rcx, %rax
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rcx
               	leaq	-0x900(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movl	$0x2000, %esi           # imm = 0x2000
               	movl	$0x35, %ecx
               	movq	%rsi, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	movl	$0x1, %edx
               	leaq	-0x910(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdx, %rdi
               	shlq	$0x3b, %rdi
               	movq	%rsi, %rcx
               	shlq	$0x3b, %rcx
               	shrq	$0x5, %rdx
               	movq	%rcx, %r8
               	orq	%rdx, %r8
               	leaq	-0x920(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	movq	%rdi, %rdx
               	orq	$0xb, %rdx
               	movq	%r8, %rdi
               	orq	%rsi, %rdi
               	leaq	-0x930(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x940(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movabsq	$0xfffffffffffffff, %rcx # imm = 0xFFFFFFFFFFFFFFF
               	andq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x5, %rdx
               	movq	%rcx, %rdi
               	shrq	$0x3b, %rdi
               	orq	%rsi, %rdi
               	movq	(%rax), %r8
               	movq	0x8(%rax), %r9
               	andq	$0x1f, %r8
               	andq	$-0x2, %r9
               	orq	%r8, %rdx
               	orq	%r9, %rdi
               	movq	%rdx, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x950(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0xa00(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	andq	$-0x1fffff, %rcx        # imm = 0xFFE00001
               	orq	$0x1ffffe, %rcx         # imm = 0x1FFFFE
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa00(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	shrq	$0x5, %rcx
               	shlq	$0x3b, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	leaq	-0xa00(%rbp), %rax
               	movq	0x8(%rax), %rax
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
               	leaq	-0xa10(%rbp), %rcx
               	movl	$0x1, %edx
               	xorq	%rax, %rax
               	leaq	-0x2a0(%rbp), %rsi
               	movq	%rdx, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rax, %rsi
               	movq	0x8(%rcx), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rax, %r8
               	orq	%rdx, %r8
               	orq	%rsi, %rdi
               	movq	%r8, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x2b0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0xa10(%rbp), %rcx
               	leaq	-0xa10(%rbp), %rsi
               	movq	(%rsi), %rdi
               	movq	0x8(%rsi), %rsi
               	movabsq	$0xfffffffff, %r8       # imm = 0xFFFFFFFFF
               	andq	%rsi, %r8
               	leaq	-0x2c0(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%r8, 0x8(%rsi)
               	leaq	-0x2d0(%rbp), %rsi
               	movq	%rdx, (%rsi)
               	movq	%rax, 0x8(%rsi)
               	movq	%rdx, %r9
               	shlq	$0x1a, %r9
               	leaq	-0x2e0(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%r9, 0x8(%rsi)
               	leaq	(%rdi,%rax), %rsi
               	cmpq	%rdi, %rsi
               	setb	%dil
               	movzbq	%dil, %rdi
               	addq	%r9, %r8
               	addq	%rdi, %r8
               	leaq	-0x2f0(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%r8, 0x8(%rdi)
               	leaq	-0x300(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%r8, 0x8(%rdi)
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%r8, %rdi
               	movq	0x8(%rcx), %r8
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r8
               	orq	%rsi, %rax
               	orq	%rdi, %r8
               	movq	%rax, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	leaq	-0x310(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x320(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	leaq	-0xa10(%rbp), %rdx
               	movq	(%rdx), %rcx
               	movq	0x8(%rdx), %rdx
               	movabsq	$0xfffffffff, %r8       # imm = 0xFFFFFFFFF
               	andq	%rdx, %r8
               	leaq	-0x330(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	%r8, 0x8(%rdx)
               	movl	$0x3, %edx
               	xorq	%rsi, %rsi
               	movq	%rcx, %rdi
               	imulq	%rdx, %rdi
               	movl	%ecx, %r9d
               	movq	%rcx, %rbx
               	shrq	$0x20, %rbx
               	movq	%r9, %r12
               	imulq	%rdx, %r12
               	shrq	$0x20, %r12
               	movq	%rbx, %r13
               	imulq	%rdx, %r13
               	addq	%r13, %r12
               	movl	%r12d, %r13d
               	shrq	$0x20, %r12
               	imulq	%rsi, %r9
               	addq	%r13, %r9
               	shrq	$0x20, %r9
               	imulq	%rsi, %rbx
               	addq	%r12, %rbx
               	addq	%rbx, %r9
               	imulq	%rsi, %rcx
               	imulq	%rdx, %r8
               	addq	%r9, %rcx
               	addq	%rcx, %r8
               	leaq	-0x340(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	leaq	-0x350(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%r8, %rcx
               	movq	0x8(%rax), %r8
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r8
               	orq	%rdi, %rsi
               	orq	%rcx, %r8
               	movq	%rsi, (%rax)
               	movq	%r8, 0x8(%rax)
               	leaq	-0x360(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	leaq	-0xa10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	leaq	-0x380(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	cmpq	$0x1, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	decq	%rdx
               	subq	$0x0, %rsi
               	subq	%rcx, %rsi
               	leaq	-0x390(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x3a0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rdx, %rdi
               	orq	$0x0, %rdi
               	orq	%rcx, %rsi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x3b0(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	leaq	-0xa10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdi
               	leaq	-0x3d0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movq	%rsi, %rdx
               	shlq	$0x5, %rdx
               	movq	%rdi, %rcx
               	shlq	$0x5, %rcx
               	shrq	$0x3b, %rsi
               	orq	%rcx, %rsi
               	leaq	-0x3e0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x3f0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rdx, %rdi
               	orq	$0x0, %rdi
               	orq	%rcx, %rsi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x400(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	leaq	-0xa10(%rbp), %rcx
               	movq	(%rcx), %rdi
               	movq	0x8(%rcx), %rcx
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	leaq	-0x420(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movq	%rdx, %rsi
               	sarq	$0x3, %rsi
               	movq	%rdi, %rcx
               	shrq	$0x3, %rcx
               	shlq	$0x3d, %rdx
               	orq	%rcx, %rdx
               	leaq	-0x430(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x440(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rdx, %rdi
               	orq	$0x0, %rdi
               	orq	%rcx, %rsi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x450(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x460(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	leaq	-0xa10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	leaq	-0x470(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movl	$0xff, %r8d
               	xorq	%rdi, %rdi
               	orq	%r8, %rdx
               	orq	%rdi, %rsi
               	leaq	-0x480(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x490(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	orq	%rdx, %rdi
               	orq	%rcx, %rsi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x4a0(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x4b0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x30000000, %esi       # imm = 0x30000000
               	movl	$0x4c, %ecx
               	movq	%rsi, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	leaq	-0xa10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdi
               	leaq	-0x4c0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movl	$0xf, %r8d
               	leaq	-0x4d0(%rbp), %rcx
               	movq	%r8, (%rcx)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rcx)
               	xorq	$-0x1, %r8
               	movq	%rsi, %r9
               	xorq	$-0x1, %r9
               	leaq	-0x4e0(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	andq	%r8, %rdx
               	andq	%r9, %rdi
               	leaq	-0x4f0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x500(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	orq	%rdx, %rsi
               	orq	%rcx, %rdi
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x510(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x520(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	leaq	-0xa10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	leaq	-0x530(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	xorq	%rdi, %rdi
               	xorq	$0x55, %rdx
               	xorq	%rdi, %rsi
               	leaq	-0x540(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x550(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	orq	%rdx, %rdi
               	orq	%rcx, %rsi
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x560(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x570(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	leaq	-0x580(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %r12
               	sarq	$0x3f, %r12
               	movq	%rdx, %rax
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
               	movq	%rcx, %r8
               	xorq	%rdx, %r8
               	cmpq	%rdx, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdi, %rcx
               	subq	%rdx, %rcx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	subq	%r10, %rdx
               	subq	%r9, %rdx
               	leaq	-0x250(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x260(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movq	0x38(%rsp), %r10
               	movq	0x8(%r10), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rcx, %rsi
               	orq	$0x0, %rsi
               	orq	%rdx, %rax
               	movq	0x38(%rsp), %r10
               	movq	%rsi, (%r10)
               	movq	0x38(%rsp), %r10
               	movq	%rax, 0x8(%r10)
               	leaq	-0x270(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x280(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	leaq	-0x290(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %r12
               	sarq	$0x3f, %r12
               	movq	%rdx, %rax
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
               	leaq	-0xc0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movq	0x38(%rsp), %r10
               	movq	0x8(%r10), %rax
               	xorq	%rsi, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rsi, %rdi
               	orq	%rcx, %rdi
               	orq	%rdx, %rax
               	movq	0x38(%rsp), %r10
               	movq	%rdi, (%r10)
               	movq	0x38(%rsp), %r10
               	movq	%rax, 0x8(%r10)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	leaq	-0x100(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rsi, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rsi, %rdi
               	xorq	$-0x1, %rdi
               	leaq	-0x110(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x120(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdi, %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	orq	%rdx, %r8
               	orq	%rcx, %rdi
               	movq	%r8, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x130(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rdi
               	leaq	-0x140(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	%rdi, 0x8(%rdx)
               	leaq	0x1(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %rdi
               	addq	%rdi, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	orq	%rdx, %r8
               	orq	%rcx, %rdi
               	movq	%r8, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x150(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rcx
               	xorq	%rax, %rax
               	leaq	-0x170(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	movq	0x8(%rcx), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rax, %rdi
               	orq	%rax, %rdi
               	orq	%rdx, %rsi
               	movq	%rdi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x180(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0xa10(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rdi
               	movabsq	$0xfffffffff, %r8       # imm = 0xFFFFFFFFF
               	andq	%rdi, %r8
               	movabsq	$-0x1, %r9
               	leaq	-0x1(%rsi), %rdx
               	cmpq	%rsi, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	decq	%r8
               	addq	%r8, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	orq	%rdx, %rax
               	orq	%rsi, %rdi
               	movq	%rax, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x190(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x1a0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	movl	$0x5e, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%r9, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movl	$0x5, %edx
               	xorq	%rsi, %rsi
               	leaq	-0x1b0(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	orq	%rdx, %r8
               	orq	%rcx, %rdi
               	movq	%r8, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x1c0(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$0xfffffffff, %r9       # imm = 0xFFFFFFFFF
               	andq	%rdi, %r9
               	leaq	-0x1d0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%r9, 0x8(%rdi)
               	leaq	0x1(%rcx), %r8
               	cmpq	%rcx, %r8
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %r9
               	addq	%r9, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movq	0x8(%rax), %r9
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r9
               	movq	%rsi, %rbx
               	orq	%r8, %rbx
               	orq	%rcx, %r9
               	movq	%rbx, (%rax)
               	movq	%r9, 0x8(%rax)
               	leaq	-0x1e0(%rbp), %rax
               	movq	%r8, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x61, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x1f0(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0xa10(%rbp), %rax
               	movl	$0x5, %edx
               	xorq	%rsi, %rsi
               	leaq	-0x200(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rcx
               	movq	0x8(%rax), %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	orq	%rdx, %r8
               	orq	%rcx, %rdi
               	movq	%r8, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x210(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rdi
               	movabsq	$0xfffffffff, %r8       # imm = 0xFFFFFFFFF
               	andq	%rdi, %r8
               	leaq	0x1(%rdx), %rcx
               	cmpq	%rdx, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	$0x0, %r8
               	addq	%r8, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdi
               	movq	%rsi, %r8
               	orq	%rcx, %r8
               	orq	%rdx, %rdi
               	movq	%r8, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	-0x220(%rbp), %rdi
               	movq	%rcx, (%rdi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x9a0(%rbp), %rcx
               	xorq	%rax, %rax
               	leaq	-0x230(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	movq	0x8(%rcx), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rax, %rdi
               	orq	%rax, %rdi
               	orq	%rdx, %rsi
               	movq	%rdi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x240(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x9a0(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	orq	%rdx, %rax
               	movabsq	$0x3e8000000000, %rdx   # imm = 0x3E8000000000
               	orq	%rsi, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x9a0(%rbp), %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x9a0(%rbp), %rax
               	movq	0x8(%rax), %rax
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
               	leaq	-0x9a0(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	shrq	$0x24, %rcx
               	andq	$0xfffffff, %rcx        # imm = 0xFFFFFFF
               	addq	$0x7, %rcx
               	andq	$0xfffffff, %rcx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rcx
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	orq	$0x0, %rdx
               	orq	%rsi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9a0(%rbp), %rax
               	movq	0x8(%rax), %rax
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
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rcx
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	leaq	0x1(%rdx), %rsi
               	movq	%rsi, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rdi, %rsi
               	orq	$0x0, %rsi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9a0(%rbp), %rax
               	movq	0x8(%rax), %rax
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
               	leaq	-0x970(%rbp), %rcx
               	xorq	%rax, %rax
               	leaq	-0xa0(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	movq	0x8(%rcx), %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movq	%rax, %rdi
               	orq	%rax, %rdi
               	orq	%rdx, %rsi
               	movq	%rdi, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x1c, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x1c, %rcx
               	movq	%rax, %rdx
               	shrq	$0x24, %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x1c, %rdx
               	shrq	$0x1c, %rsi
               	shlq	$0x24, %rcx
               	orq	%rcx, %rsi
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x970(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	orq	%rdx, %rax
               	movabsq	$-0x5000000000, %rdx    # imm = 0xFFFFFFB000000000
               	orq	%rsi, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x970(%rbp), %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	shlq	$0x24, %rax
               	movq	%rax, %rcx
               	sarq	$0x24, %rcx
               	cmpq	$-0x5, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x970(%rbp), %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	shlq	$0x24, %rax
               	movq	%rax, %rcx
               	sarq	$0x24, %rcx
               	testq	%rcx, %rcx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
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
               	leaq	-0x9a0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x10(%rbp), %rdi
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0x20(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	shlq	$0x10, %rdx
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movl	$0x99, %r8d
               	movq	%rax, %rsi
               	orq	%r8, %rsi
               	orq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x980(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x990(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x980(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rdi
               	leaq	-0x50(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x990(%rbp), %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdi
               	movq	0x8(%rdx), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rax, %r9
               	orq	%rsi, %r9
               	orq	%rdi, %rcx
               	movq	%r9, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	leaq	-0x60(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movl	$0x123, %edx            # imm = 0x123
               	leaq	-0x70(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x990(%rbp), %rcx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rdx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rdi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdi
               	orq	%rsi, %rax
               	orq	%rdi, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x990(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	leaq	-0x80(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x10000, %esi          # imm = 0x10000
               	movl	$0x72, %ecx
               	movq	%rsi, %rdx
               	xchgq	%rcx, %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xa60, %rsp            # imm = 0xA60
               	popq	%rbp
               	retq
               	leaq	-0x990(%rbp), %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	xorq	%rsi, %rsi
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	leaq	-0x90(%rbp), %rdi
               	movq	%rax, (%rdi)
               	sarq	$0x3f, %rax
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
