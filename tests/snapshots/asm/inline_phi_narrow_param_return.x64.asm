
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
               	movslq	%edi, %rdi
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0xf4243, %rcx, %rcx    # imm = 0xF4243
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	incq	%rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x32, %edi
               	callq	<addr>
               	cmpq	$-0x4728dfba, %rax      # imm = 0xB8D72046
               	jne	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
