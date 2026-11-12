
bitfield_attribute_after_width.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	$0x0, -0x8(%rbp)
               	movb	$0x2, -0x7(%rbp)
               	movl	-0x8(%rbp), %eax
               	andq	$-0x10, %rax
               	orq	$0xd, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$-0xf1, %rax
               	orq	$0x50, %rax
               	movl	%eax, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	cmpl	$0x5d, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	movl	%eax, %eax
               	sarq	$0x4, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movsbq	-0x7(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movb	$0x4, -0x7(%rbp)
               	movl	-0x8(%rbp), %ecx
               	andq	$-0x10, %rcx
               	orq	$0x8, %rcx
               	movl	%ecx, -0x8(%rbp)
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpl	$-0x8, %ecx
               	jne	<addr>
               	movsbq	-0x7(%rbp), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	movb	$0x0, -0x4(%rbp)
               	movb	$0x0, -0x3(%rbp)
               	movb	$0x5, -0x8(%rbp)
               	movb	$0x6, -0x3(%rbp)
               	movl	-0x7(%rbp), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x38a432eb, %rax       # imm = 0x38A432EB
               	movl	%eax, -0x7(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$0xf8a432eb, %ecx       # imm = 0xF8A432EB
               	jne	<addr>
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x1fffffff, %rax       # imm = 0x1FFFFFFF
               	movl	%eax, -0x7(%rbp)
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0x1fffffff, %eax       # imm = 0x1FFFFFFF
               	jne	<addr>
               	movq	$0x0, -0x30(%rbp)
               	movb	$0x8, -0x2b(%rbp)
               	movq	-0x30(%rbp), %rax
               	movabsq	$-0x10000000000, %r11   # imm = 0xFFFFFF0000000000
               	andq	%r11, %rax
               	movabsq	$0xfedcba9877, %r11     # imm = 0xFEDCBA9877
               	orq	%r11, %rax
               	movq	%rax, -0x30(%rbp)
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	-0x2b(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movzbq	-0x30(%rbp), %rax
               	cmpl	$0x77, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movb	$0xb, -0x6(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	andq	$-0x1000, %rax          # imm = 0xF000
               	orq	$0x7ff, %rax            # imm = 0x7FF
               	movw	%ax, -0x8(%rbp)
               	shlq	$0x34, %rax
               	sarq	$0x34, %rax
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	jne	<addr>
               	movb	$0x12, -0x8(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shlq	$0x34, %rcx
               	sarq	$0x34, %rcx
               	cmpl	$0x712, %ecx            # imm = 0x712
               	jne	<addr>
               	andq	$-0x1000, %rax          # imm = 0xF000
               	orq	$0x800, %rax            # imm = 0x800
               	movw	%ax, -0x8(%rbp)
               	shlq	$0x34, %rax
               	sarq	$0x34, %rax
               	cmpl	$0xfffff800, %eax       # imm = 0xFFFFF800
               	jne	<addr>
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1e, %eax
               	leave
               	retq
               	movl	$0x1d, %eax
               	leave
               	retq
               	movl	$0x1c, %eax
               	leave
               	retq
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	$0x17, %eax
               	leave
               	retq
