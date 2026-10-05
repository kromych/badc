
builtin_ffs.x64:	file format elf64-x86-64

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
               	movl	$0xff0000, -0x10(%rbp)  # imm = 0xFF0000
               	movslq	-0x10(%rbp), %rax
               	movl	$0x20, %r11d
               	bsfl	%eax, %ecx
               	cmovel	%r11d, %ecx
               	xorl	%eax, %eax
               	cmpl	$0x20, %ecx
               	leaq	0x1(%rcx), %rcx
               	cmovel	%eax, %ecx
               	cmpl	$0x11, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	bsfl	%ecx, %ecx
               	leaq	0x1(%rcx), %rcx
               	cmovel	%eax, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leave
               	retq
