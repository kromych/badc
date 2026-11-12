
zero_sign_extension_32bit.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x80000001, %ebx       # imm = 0x80000001
               	je	<addr>
               	movl	$0x28, %ecx
               	movl	%ecx, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x80000001, %ebx       # imm = 0x80000001
               	je	<addr>
               	movl	$0x29, %ecx
               	movl	%ecx, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5e, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	popq	%rbx
               	leave
               	retq
