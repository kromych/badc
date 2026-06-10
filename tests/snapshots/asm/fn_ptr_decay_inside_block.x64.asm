
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<adder>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rcx       # <addr>
               	jmp	<addr>
               	leaq	-<rip>, %r12       # <addr>
               	movl	$0x1, %edi
               	movq	%r12, %r11
               	callq	*%r11
               	addq	%rbx, %rax
               	movslq	%eax, %rbx
               	movl	$0x2, %edi
               	movq	%r12, %r11
               	callq	*%r11
               	addq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	movl	$0x3, %edi
               	movq	%rcx, %r11
               	callq	*%r11
               	addq	%rax, %rbx
               	jmp	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x48(%rbp)
               	movslq	%ebx, %rbx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x4, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x19a, %rax            # imm = 0x19A
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
