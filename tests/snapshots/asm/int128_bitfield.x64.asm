
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
               	subq	$0xf8, %rsp
               	pushq	%r14
               	pushq	%r12
               	pushq	%rbx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	0x8(%rcx), %rax
               	shrq	$0x24, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
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
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
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
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	cmpl	$0xfffffff, %eax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x1d, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	cmpl	$0xfffffff, %eax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x23, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
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
               	movabsq	$-0x3000000000, %rcx    # imm = 0xFFFFFFD000000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	orq	$0xf000000, %rax        # imm = 0xF000000
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	shlq	$0x24, %rax
               	movq	%rax, %rdx
               	sarq	$0x24, %rdx
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	cmpl	$-0x3, %edx
               	je	<addr>
               	movl	$0x2c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movabsq	$0x800000000, %rcx      # imm = 0x800000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
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
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rcx
               	movb	$-0x55, (%rcx)
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	andq	$0xff, %rax
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rdx
               	movq	%rax, %rsi
               	orq	$0x300, %rsi            # imm = 0x300
               	movq	%rdx, %rax
               	orq	$0x200000, %rax         # imm = 0x200000
               	movq	%rsi, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	shlq	$0x38, %rax
               	orq	$0x3, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movzbq	(%rcx), %rax
               	xorq	$0xab, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
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
               	movq	%rcx, %rdx
               	orq	$0x1ffffe, %rdx         # imm = 0x1FFFFE
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, %rcx
               	shrq	$0x5, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x3b, %rsi
               	orq	%rsi, %rcx
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x80000000000000b, %r11 # imm = 0x80000000000000B
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x39, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movl	(%rax), %eax
               	andq	$0x1f, %rax
               	cmpl	$0x1f, %eax
               	jne	<addr>
               	movq	%rdx, %rax
               	sarq	%rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	$0xfffff, %eax          # imm = 0xFFFFF
               	je	<addr>
               	movl	$0x3c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	addq	$0x4000000, %rcx        # imm = 0x4000000
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	cmpq	$0x4000000, %rdx        # imm = 0x4000000
               	je	<addr>
               	movl	$0x3e, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	(%rdx,%rdx,2), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, %rdx
               	orq	%rax, %rdx
               	movq	%rdx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rcx
               	cmpq	$0xc000000, %rcx        # imm = 0xC000000
               	je	<addr>
               	movl	$0x41, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rdx, %rax
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	cmpq	$0xc000000, %rdx        # imm = 0xC000000
               	je	<addr>
               	movl	$0x44, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	%rdx, %rax
               	shlq	$0x5, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	movabsq	$0x180000000, %r11      # imm = 0x180000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x47, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	%rdx, %rax
               	sarq	$0x3, %rax
               	shlq	$0x3d, %rdx
               	movq	%rdx, %rdi
               	orq	$0x8, %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, %rdx
               	orq	%rax, %rdx
               	movq	%rdx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rsi
               	cmpq	$0x8, %rdi
               	je	<addr>
               	movl	$0x49, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rdi, %rax
               	orq	$0xff, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	movq	%rcx, %rdi
               	orq	%rax, %rdi
               	orq	%rsi, %rdx
               	movq	%rdx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rsi
               	cmpq	$0xff, %rdi
               	je	<addr>
               	movl	$0x4c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	andq	$-0x10, %rdi
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rdx, %rax
               	movq	%rax, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rsi
               	cmpq	$0xf0, %rdi
               	je	<addr>
               	movl	$0x4f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	%rdi, %rax
               	xorq	$0x55, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	movq	%rcx, %rdi
               	orq	%rax, %rdi
               	movq	%rdx, %r14
               	orq	%rsi, %r14
               	movq	%r14, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%r14, %rcx
               	cmpq	$0xa5, %rdi
               	je	<addr>
               	movl	$0x52, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	testq	%rdi, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movl	$0x7, %r9d
               	testq	%rdx, %rdx
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %esi
               	movq	%rdi, %rcx
               	movq	%rax, %rdi
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rax
               	movq	%rbx, %rdi
               	orq	%r8, %rdi
               	movq	%rcx, %rbx
               	shlq	%rbx
               	shlq	%rdx
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rdx
               	testq	%rax, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x7, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r8
               	orq	%r8, %rcx
               	xorq	$0x1, %rcx
               	xorl	%r8d, %r8d
               	subq	%rcx, %r8
               	andq	%r9, %r8
               	cmpq	%r8, %rdi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r8, %rdi
               	subq	%r12, %rax
               	orq	%rbx, %rcx
               	decq	%rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rcx, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rsi, %rdx
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%r14, %rdx
               	movq	%rdx, %r14
               	orq	%rax, %r14
               	movq	%r14, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%r14, %rdx
               	movabsq	$-0x249249249249247b, %r11 # imm = 0xDB6DB6DB6DB6DB85
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x55, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	subq	%rsi, %rdx
               	movl	$0xf4243, %r8d          # imm = 0xF4243
               	testq	%rdx, %rdx
               	je	<addr>
               	xorl	%eax, %eax
               	movl	$0x80, %esi
               	movq	%rcx, %rdi
               	movq	%rax, %rcx
               	movq	%rdx, %r9
               	shrq	$0x3f, %r9
               	movq	%rcx, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	orq	%r9, %rcx
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rdx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rdx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rcx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r9
               	orq	%r9, %rdi
               	xorq	$0x1, %rdi
               	xorl	%r9d, %r9d
               	subq	%rdi, %r9
               	andq	%r8, %r9
               	cmpq	%r9, %rcx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r9, %rcx
               	subq	%r12, %rax
               	orq	%rbx, %rdi
               	decq	%rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rcx, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%r14, %rdx
               	orq	%rax, %rdx
               	movq	%rdx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	cmpq	$0x247c3, %rcx          # imm = 0x247C3
               	je	<addr>
               	movl	$0x58, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rdx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	decq	%rcx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x62, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x28(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x68, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x3e8000000000, %r11   # imm = 0x3E8000000000
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	cmpl	$0x3e8, %ecx            # imm = 0x3E8
               	jne	<addr>
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x3ef000000000, %r11   # imm = 0x3EF000000000
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	cmpl	$0x3ef, %ecx            # imm = 0x3EF
               	je	<addr>
               	movl	$0x6c, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x3f0000000000, %r11   # imm = 0x3F0000000000
               	orq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	cmpl	$0x3f0, %ecx            # imm = 0x3F0
               	je	<addr>
               	movl	$0x6d, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movq	-0x28(%rbp), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x5000000000, %r11    # imm = 0xFFFFFFB000000000
               	orq	%r11, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	shlq	$0x24, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x24, %rsi
               	cmpl	$-0x5, %esi
               	jne	<addr>
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x70, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x6e, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movl	$0x6b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x59, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0xc6f45449cb59c69, %rsi # imm = 0xC6F45449CB59C69
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	movq	%rax, %rdi
               	shrq	$0x13, %rdi
               	movq	%rdi, %rax
               	imulq	%r8, %rax
               	subq	%rax, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	cmpq	$0x6db6db6, %rdx        # imm = 0x6DB6DB6
               	je	<addr>
               	movl	$0x56, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0x2492492492492493, %rcx # imm = 0x2492492492492493
               	movq	%rdi, %rax
               	mulq	%rcx
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	movq	%rcx, %rax
               	imulq	%r9, %rax
               	subq	%rax, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	cmpq	$0x30000000, %rcx       # imm = 0x30000000
               	je	<addr>
               	movl	$0x53, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpq	$0x30000000, %rsi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x50, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpq	$0x30000000, %rsi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4d, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	cmpq	$0x30000000, %rsi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	cmpq	$0x2000, %rdx           # imm = 0x2000
               	je	<addr>
               	movl	$0x36, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x33, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x800000000, %r11     # imm = 0xFFFFFFF800000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x30, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x2d, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
