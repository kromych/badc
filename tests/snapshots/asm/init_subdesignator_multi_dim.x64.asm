
init_subdesignator_multi_dim.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rdx
               	movzwq	0xa(%rax), %rsi
               	movl	0x24(%rax), %edi
               	movl	0x2c(%rax), %r8d
               	movl	0x98(%rax), %r9d
               	movq	%rcx, %rbx
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movq	%rdx, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%rsi, %r13
               	andq	$0xffff, %r13           # imm = 0xFFFF
               	movslq	%edi, %rsi
               	movslq	%r8d, %rdi
               	movslq	%r9d, %r8
               	xorq	%rcx, %rcx
               	movzwq	(%rax), %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzwq	0x2(%rax), %rcx
               	xorq	$0x2, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzwq	0xa(%rax), %rcx
               	xorq	$0x7, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x24(%rax), %rcx
               	cmpq	$0x5, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x2c(%rax), %rcx
               	cmpq	$0x6, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x98(%rax), %rcx
               	cmpq	$0x9, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzwq	0x6(%rax), %rcx
               	testq	%rcx, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x18(%rax), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x3c(%rax), %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%r12, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r13, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x5, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x6, %rdi
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x9, %r8
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movslq	0x54(%rax), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x6c(%rax), %rax
               	cmpq	$0x3, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movzwq	0x8(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	0x98(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
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
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
