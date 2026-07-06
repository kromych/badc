
mmap_anonymous.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x4000, %ebx           # imm = 0x4000
               	xorq	%rdi, %rdi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movabsq	$-0x1, %r8
               	movq	%rbx, %rsi
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	cmpq	%rbx, %rdx
               	jae	<addr>
               	jmp	<addr>
               	addq	$0x1000, %rdx           # imm = 0x1000
               	jmp	<addr>
               	leaq	(%rax,%rdx), %rcx
               	movq	%rdx, %rsi
               	shrq	$0xc, %rsi
               	incq	%rsi
               	movb	%sil, (%rcx)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	%rbx, %rdx
               	jae	<addr>
               	jmp	<addr>
               	addq	$0x1000, %rdx           # imm = 0x1000
               	jmp	<addr>
               	leaq	(%rax,%rdx), %rcx
               	movsbq	(%rcx), %rcx
               	movq	%rdx, %rsi
               	shrq	$0xc, %rsi
               	incq	%rsi
               	movsbq	%sil, %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	%rax, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
