
has_builtin_clrsb.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0xff, -0x8(%rbp)
               	movq	$-0x400, -0x10(%rbp)    # imm = 0xFC00
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	xorq	%rcx, %rax
               	orq	$0x1, %rax
               	movl	$0x3f, %r11d
               	bsrl	%eax, %eax
               	cmovel	%r11d, %eax
               	xorl	$0x1f, %eax
               	cmpl	$0x17, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	xorq	%rcx, %rax
               	orq	$0x1, %rax
               	movl	$0x7f, %r11d
               	bsrq	%rax, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	cmpl	$0x35, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
