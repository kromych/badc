
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
               	bsfl	%eax, %eax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rcx
               	shrq	$0x5, %rax
               	decq	%rax
               	andq	%rcx, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	movl	$0x20, %r11d
               	bsfl	%ecx, %ecx
               	cmovel	%r11d, %ecx
               	leaq	0x1(%rcx), %rdx
               	shrq	$0x5, %rcx
               	decq	%rcx
               	andq	%rdx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leave
               	retq
