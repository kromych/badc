
inline_asm_goto_output.x64:	file format elf64-x86-64

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

<classify>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movslq	%edi, %rdi
               	movq	%rdi, %rbx
               	movl	%ebx, %eax
               	addl	$0x1, %eax
               	cmpl	$0xa, %ebx
               	jg	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	popq	%rbx
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq

<accumulate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movl	%edi, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	addl	$0x5, %eax
               	jmp	<addr>
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movq	$-0x1, %rax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x3, %ebx
               	movl	%ebx, %eax
               	addl	$0x1, %eax
               	cmpl	$0xa, %ebx
               	jg	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x14, %ebx
               	movl	%ebx, %eax
               	addl	$0x1, %eax
               	cmpl	$0xa, %ebx
               	jg	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x25, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	addl	$0x5, %eax
               	jmp	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movq	$-0x1, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x64, %rax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x64, %rax
               	jmp	<addr>
