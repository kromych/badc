
switch_nested_case_in_compound.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	addq	$0x2, %rax
               	leaq	0x4(%rax), %rcx
               	jmp	<addr>
               	movl	$0x4000, %ecx           # imm = 0x4000
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1064, %ecx           # imm = 0x1064
               	jmp	<addr>
               	movl	$0x2064, %ecx           # imm = 0x2064
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ecx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x106b, %rax           # imm = 0x106B
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	addq	$0x2, %rax
               	leaq	0x4(%rax), %rcx
               	jmp	<addr>
               	movl	$0x4000, %ecx           # imm = 0x4000
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1064, %ecx           # imm = 0x1064
               	jmp	<addr>
               	movl	$0x2064, %ecx           # imm = 0x2064
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ecx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
