
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x2, %eax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x64, %eax
               	leaq	(%rbx,%rax), %rcx
               	cmpq	$0x64, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	0x1(%rbx), %rax
               	addq	$0x2, %rax
               	leaq	0x4(%rax), %rbx
               	jmp	<addr>
               	orq	$0x4000, %rbx           # imm = 0x4000
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rbx
               	orq	$0x1000, %rbx           # imm = 0x1000
               	jmp	<addr>
               	movq	%rcx, %rbx
               	orq	$0x2000, %rbx           # imm = 0x2000
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movl	$0x1, %eax
               	cmpq	$0x2, %rax
               	jl	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x106b, %rax           # imm = 0x106B
               	je	<addr>
               	jmp	<addr>
               	movl	$0x64, %eax
               	leaq	(%rbx,%rax), %rcx
               	cmpq	$0x64, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	0x1(%rbx), %rax
               	addq	$0x2, %rax
               	leaq	0x4(%rax), %rbx
               	jmp	<addr>
               	orq	$0x4000, %rbx           # imm = 0x4000
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rbx
               	orq	$0x1000, %rbx           # imm = 0x1000
               	jmp	<addr>
               	movq	%rcx, %rbx
               	orq	$0x2000, %rbx           # imm = 0x2000
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
