
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x1234, %rcx           # imm = 0x1234
               	je	<addr>
               	movl	$0xa, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$0x800000000, %rcx      # imm = 0x800000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	orq	$0x0, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1b, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	cmpl	$0xfffffff, %ecx        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x1d, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	cmpl	$0xfffffff, %eax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x23, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	-0x28(%rbp), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x3000000000, %r11    # imm = 0xFFFFFFD000000000
               	orq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	shlq	$0x1c, %rdx
               	orq	$0xf000000, %rdx        # imm = 0xF000000
               	movq	%rdx, %rsi
               	sarq	$0x1c, %rsi
               	shlq	$0x24, %rdx
               	orq	$0x0, %rdx
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x29, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	shlq	$0x24, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x24, %rsi
               	movq	%rsi, %rdx
               	sarq	$0x3f, %rdx
               	cmpq	$-0x3, %rsi
               	je	<addr>
               	movl	$0x2c, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	orq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	shlq	$0x1c, %rdx
               	orq	$0x0, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x1c, %rsi
               	shlq	$0x24, %rdx
               	orq	$0x0, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1c, %rax
               	orq	$0x0, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rax
               	movl	$0xab, %ecx
               	movb	%cl, (%rax)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rcx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rdx
               	movq	%rcx, %rsi
               	orq	$0x300, %rsi            # imm = 0x300
               	movq	%rdx, %rcx
               	orq	$0x200000, %rcx         # imm = 0x200000
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	shlq	$0x38, %rcx
               	orq	$0x3, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x35, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movzbq	(%rax), %rax
               	xorq	$0xab, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x20, %rcx
               	orq	$0x1f, %rcx
               	movl	%ecx, (%rax)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	andq	$0x1f, %rcx
               	andq	$-0x2, %rdx
               	movq	%rcx, %rsi
               	orq	$0x160, %rsi            # imm = 0x160
               	movq	%rdx, %rcx
               	orq	$0x1, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	andq	$-0x1fffff, %rcx        # imm = 0xFFE00001
               	orq	$0x1ffffe, %rcx         # imm = 0x1FFFFE
               	movq	%rcx, 0x8(%rax)
               	movq	%rsi, %rdx
               	shrq	$0x5, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3b, %rsi
               	orq	%rsi, %rdx
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$0x80000000000000b, %r11 # imm = 0x80000000000000B
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x39, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	(%rax), %eax
               	andq	$0x1f, %rax
               	cmpl	$0x1f, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	sarq	%rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	$0xfffff, %eax          # imm = 0xFFFFF
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	$0x0, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	addq	$0x4000000, %rcx        # imm = 0x4000000
               	addq	$0x0, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	cmpq	$0x4000000, %rdx        # imm = 0x4000000
               	je	<addr>
               	movl	$0x3e, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	(%rdx,%rdx,2), %rcx
               	addq	$0x0, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	cmpq	$0xc000000, %rdx        # imm = 0xC000000
               	je	<addr>
               	movl	$0x41, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	(%rdx), %rcx
               	subq	$0x0, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	cmpq	$0xc000000, %rdx        # imm = 0xC000000
               	je	<addr>
               	movl	$0x44, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rdx, %rcx
               	shlq	$0x5, %rcx
               	orq	$0x0, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	movabsq	$0x180000000, %r11      # imm = 0x180000000
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x47, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	shlq	$0x3d, %rdx
               	orq	$0x8, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	$0x0, %rdx
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x49, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rdx, %rdi
               	orq	$0xff, %rdi
               	movq	%rsi, %rdx
               	orq	%rax, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rdi
               	orq	%rdx, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	cmpq	$0xff, %rdi
               	je	<addr>
               	movl	$0x4c, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rdi, %rdx
               	andq	$-0x10, %rdx
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rsi, %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rdx, %rsi
               	orq	$0x0, %rsi
               	orq	%rdi, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdi
               	cmpq	$0xf0, %rsi
               	je	<addr>
               	movl	$0x4f, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	$0x55, %rsi
               	movq	%rdi, %rdx
               	xorq	%rax, %rdx
               	movabsq	$-0x1000000000, %rdi    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rdi
               	movq	%rax, %rcx
               	orq	%rsi, %rcx
               	movq	%rdi, %r14
               	orq	%rdx, %r14
               	movq	%r14, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%r14, %rdx
               	cmpq	$0xa5, %rcx
               	je	<addr>
               	movl	$0x52, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%r8, %r8
               	movq	%rcx, %rax
               	xorq	%r8, %rax
               	movq	%rdx, %rcx
               	xorq	%r8, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rax
               	subq	%rdx, %rax
               	movl	$0x7, %ebx
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x80, %ecx
               	movq	%r8, %rdi
               	movq	%rsi, %rdx
               	movq	%r8, %rsi
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %r9
               	shrq	$0x3f, %r9
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rdi
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rdi
               	movq	%r12, %rsi
               	orq	%r9, %rsi
               	movq	%rdx, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rax
               	testq	%rdi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	testq	%rdi, %rdi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x7, %rsi
               	setb	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r9
               	orq	%r9, %rdx
               	xorq	$0x1, %rdx
               	xorq	%r9, %r9
               	subq	%rdx, %r9
               	andq	%rbx, %r9
               	cmpq	%r9, %rsi
               	setb	%r13b
               	movzbq	%r13b, %r13
               	subq	%r9, %rsi
               	subq	$0x0, %rdi
               	subq	%r13, %rdi
               	orq	%r12, %rdx
               	decq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rdx
               	xorq	%rcx, %rax
               	testq	%rdx, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x0, %rdx
               	subq	$0x0, %rax
               	movq	%r9, %r10
               	movq	%rax, %r9
               	subq	%r10, %r9
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%r9, %rsi
               	movabsq	$-0x1000000000, %rdi    # imm = 0xFFFFFFF000000000
               	andq	%r14, %rdi
               	movq	%rdx, %rax
               	orq	$0x0, %rax
               	movq	%rdi, %r14
               	orq	%rsi, %r14
               	movq	%r14, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%r14, %rdx
               	movabsq	$-0x249249249249247b, %r11 # imm = 0xDB6DB6DB6DB6DB85
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x55, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%r8, %r8
               	xorq	%r8, %rax
               	movq	%rdx, %rcx
               	xorq	%r8, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rax
               	subq	%rdx, %rax
               	movl	$0xf4243, %r9d          # imm = 0xF4243
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x80, %ecx
               	movq	%r8, %rdi
               	movq	%rsi, %rdx
               	movq	%r8, %rsi
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rsi, %r12
               	shlq	%r12
               	shlq	%rdi
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rdi
               	movq	%r12, %rsi
               	orq	%rbx, %rsi
               	movq	%rdx, %r12
               	shlq	%r12
               	shlq	%rax
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rax
               	testq	%rdi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	testq	%rdi, %rdi
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rsi
               	setb	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rbx
               	orq	%rbx, %rdx
               	xorq	$0x1, %rdx
               	xorq	%rbx, %rbx
               	subq	%rdx, %rbx
               	andq	%r9, %rbx
               	cmpq	%rbx, %rsi
               	setb	%r13b
               	movzbq	%r13b, %r13
               	subq	%rbx, %rsi
               	subq	$0x0, %rdi
               	subq	%r13, %rdi
               	orq	%r12, %rdx
               	decq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rsi, %rax
               	xorq	%r8, %rax
               	movq	%rdi, %rcx
               	xorq	%r8, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	$0x0, %rax
               	subq	$0x0, %rcx
               	subq	%rdx, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%r14, %rdx
               	movq	%rax, %rsi
               	orq	$0x0, %rsi
               	orq	%rdx, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0x247c3, %rsi          # imm = 0x247C3
               	je	<addr>
               	movl	$0x58, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	addq	$0x0, %rcx
               	incq	%rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	orq	$0x0, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	decq	%rcx
               	addq	$0x0, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	orq	$0x0, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	leaq	(%rcx), %rdx
               	addq	$0x0, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rax, %rdx
               	movq	%rdx, -0x28(%rbp)
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x62, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rdx, %rax
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	addq	$0x0, %rax
               	addq	$0x0, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x68, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	$0x0, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x3e8000000000, %rcx   # imm = 0x3E8000000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x3ef000000000, %r11   # imm = 0x3EF000000000
               	orq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	cmpl	$0x3ef, %edx            # imm = 0x3EF
               	je	<addr>
               	movl	$0x6c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x3f0000000000, %r11   # imm = 0x3F0000000000
               	orq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	cmpl	$0x3f0, %edx            # imm = 0x3F0
               	je	<addr>
               	movl	$0x6d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	orq	$0x0, %rdx
               	movq	%rdx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x5000000000, %r11    # imm = 0xFFFFFFB000000000
               	orq	%r11, %rdx
               	movq	%rdx, -0x28(%rbp)
               	movq	%rdx, %rsi
               	shrq	$0x24, %rsi
               	shlq	$0x24, %rsi
               	movq	%rsi, %rdi
               	sarq	$0x24, %rdi
               	cmpq	$-0x5, %rdi
               	jne	<addr>
               	movq	%rax, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x70, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x6e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x6b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x59, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rax
               	imulq	%r9, %rax
               	subq	%rax, %rsi
               	movq	%r8, %rdi
               	movq	%r8, %rax
               	jmp	<addr>
               	cmpq	$0x6db6db6, %rdx        # imm = 0x6DB6DB6
               	je	<addr>
               	movl	$0x56, %ecx
               	jmp	<addr>
               	pushq	%rax
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rax
               	imulq	%rbx, %rax
               	subq	%rax, %rsi
               	movq	%r8, %rdi
               	movq	%r8, %rax
               	jmp	<addr>
               	cmpq	$0x30000000, %rdx       # imm = 0x30000000
               	je	<addr>
               	movl	$0x53, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$0x30000000, %rdi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x50, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	cmpq	$0x30000000, %rsi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4d, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	cmpq	$0x30000000, %rsi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4a, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	cmpq	$0x2000, %rdx           # imm = 0x2000
               	je	<addr>
               	movl	$0x36, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x33, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x800000000, %r11     # imm = 0xFFFFFFF800000000
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x30, %eax
               	jmp	<addr>
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x2d, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	cmpq	$-0x1, %rsi
               	je	<addr>
               	movl	$0x2a, %edx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
