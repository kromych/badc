
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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x1234, %rcx           # imm = 0x1234
               	je	<addr>
               	movl	$0xa, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	0x8(%rcx), %rax
               	shrq	$0x24, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
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
               	leave
               	retq
               	movzbq	(%rcx), %rax
               	xorq	$0xab, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movl	(%rcx), %eax
               	andq	$-0x20, %rax
               	orq	$0x1f, %rax
               	movl	%eax, (%rcx)
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	andq	$0x1f, %rax
               	andq	$-0x2, %rdx
               	orq	$0x160, %rax            # imm = 0x160
               	orq	$0x1, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	andq	$-0x1fffff, %rdx        # imm = 0xFFE00001
               	orq	$0x1ffffe, %rdx         # imm = 0x1FFFFE
               	movq	%rdx, 0x8(%rcx)
               	shrq	$0x5, %rax
               	movq	%rdx, %rsi
               	shlq	$0x3b, %rsi
               	orq	%rsi, %rax
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x80000000000000b, %r11 # imm = 0x80000000000000B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x39, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	(%rcx), %eax
               	andq	$0x1f, %rax
               	cmpl	$0x1f, %eax
               	jne	<addr>
               	movq	%rdx, %rax
               	sarq	%rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	$0xfffff, %eax          # imm = 0xFFFFF
               	je	<addr>
               	movl	$0x3c, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x1(%rax), %ecx
               	movzbq	0x5(%rax), %rax
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x79, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	movzbq	0x6(%rcx), %r10
               	movb	%r10b, 0x6(%rax)
               	movl	$0xffffffff, 0x1(%rax)  # imm = 0xFFFFFFFF
               	movb	$0x7f, 0x5(%rax)
               	movl	$0x0, 0x1(%rax)
               	movb	$-0x80, 0x5(%rax)
               	movl	$0x1, 0x1(%rax)
               	movb	$-0x80, 0x5(%rax)
               	movl	$0xfffffffe, 0x1(%rax)  # imm = 0xFFFFFFFE
               	movb	$-0x1, 0x5(%rax)
               	xorl	%eax, %eax
               	leave
               	retq
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x7a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpq	$0x2000, %rdx           # imm = 0x2000
               	je	<addr>
               	movl	$0x36, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testq	%rdx, %rdx
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
