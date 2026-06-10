
sys_addr_zero_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x2a0, %esi            # imm = 0x2A0
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r11
               	callq	*%r11
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jg	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r11
               	callq	*%r11
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq

<__c5_sys_geteuid>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<__c5_sys_getpid>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
