
has_builtin_clrsb.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movl	$0xff, 0x8(%rsp)
               	movq	$-0x400, (%rsp)         # imm = 0xFC00
               	movl	0x8(%rsp), %eax
               	movl	%eax, %r11d
               	shll	%r11d
               	xorl	%eax, %r11d
               	orl	$0x1, %r11d
               	bsrl	%r11d, %eax
               	xorl	$0x1f, %eax
               	cmpl	$0x17, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	(%rsp), %rax
               	movq	%rax, %r11
               	shlq	%r11
               	xorq	%rax, %r11
               	orq	$0x1, %r11
               	bsrq	%r11, %rax
               	xorl	$0x3f, %eax
               	cmpl	$0x35, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
