
inline_phi_narrow_param_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<trunc_id>:
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<phi_accumulate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	movl	$0x1, %edx
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	%rdi, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	imulq	$0xf4243, %rdx, %rax    # imm = 0xF4243
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	0x1(%rax), %rdx
               	jmp	<addr>
               	movq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x32, %edi
               	callq	<addr>
               	cmpq	$-0x4728dfba, %rax      # imm = 0xB8D72046
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
