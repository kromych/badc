
for_init_multiple_declarators.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	xorq	%rdx, %rdx
               	movl	$0x3, %eax
               	movq	%rdx, %rcx
               	movslq	%edx, %rsi
               	cmpq	%rax, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	$0x4, %eax
               	movl	$0x2, %ecx
               	movq	%rsi, %rdx
               	movslq	%esi, %rdi
               	cmpq	%rax, %rdi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rsi
               	incq	%rsi
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	%rcx, %rdx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	movl	$0x5, %eax
               	movq	%rdx, %rcx
               	cmpq	%rax, %rdx
               	jg	<addr>
               	jmp	<addr>
               	incq	%rdx
               	jmp	<addr>
               	imulq	%rdx, %rcx
               	jmp	<addr>
               	cmpq	$0x78, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	$0x2, %edx
               	movq	%rdx, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	movslq	%edx, %rcx
               	movslq	%eax, %rdi
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	movslq	%esi, %rcx
               	movq	%rcx, %rsi
               	incq	%rsi
               	jmp	<addr>
               	movslq	%esi, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
