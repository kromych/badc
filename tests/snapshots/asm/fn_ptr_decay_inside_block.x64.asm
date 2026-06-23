
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<adder>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rcx       # <addr>
               	jmp	<addr>
               	leaq	-<rip>, %r12       # <addr>
               	movl	$0x1, %edi
               	movq	%r12, %r11
               	callq	*%r11
               	addq	%rax, %rbx
               	movl	$0x2, %edi
               	movq	%r12, %r11
               	callq	*%r11
               	addq	%rax, %rbx
               	jmp	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x3, %edi
               	movq	%rcx, %r11
               	callq	*%r11
               	addq	%rax, %rbx
               	jmp	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x48(%rbp)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
