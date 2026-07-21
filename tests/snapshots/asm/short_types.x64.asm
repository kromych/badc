
short_types.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	xorq	%rax, %rax
               	movabsq	$-0x8000, %rax          # imm = 0x8000
               	leaq	-0xd8(%rbp), %rax
               	movl	$0x64, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xd8(%rbp), %rax
               	movl	$0xc8, %ecx
               	movw	%cx, 0x2(%rax)
               	leaq	-0xd8(%rbp), %rax
               	movabsq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, 0x4(%rax)
               	leaq	-0xd8(%rbp), %rdx
               	leaq	-0xd8(%rbp), %rax
               	movswq	(%rax), %rcx
               	leaq	-0xd8(%rbp), %rax
               	movswq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0xd8(%rbp), %rcx
               	movswq	0x4(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movslq	%ecx, %rax
               	movq	%rax, %rsi
               	andq	$0x8000, %rsi           # imm = 0x8000
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	-0x10000(%rcx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movw	%ax, 0x6(%rdx)
               	leaq	-0xd8(%rbp), %rax
               	movswq	0x6(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x7, %ecx
               	movw	%cx, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	movabsq	$-0x7, %rcx
               	movw	%cx, 0x2(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movl	$0xc0de, %ecx           # imm = 0xC0DE
               	movw	%cx, 0x4(%rax)
               	leaq	-0xe0(%rbp), %rax
               	movswq	(%rax), %rcx
               	leaq	-0xe0(%rbp), %rax
               	movswq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	movzwq	0x4(%rax), %rax
               	xorq	$0xc0de, %rax           # imm = 0xC0DE
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	<addr>
