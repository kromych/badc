
binop_imm_chain_fold.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	movq	%r11, %rcx
               	addq	$0x8, %rcx
               	movslq	%ecx, %rcx
               	subq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	movq	%r11, %rdx
               	subq	$0x4, %rdx
               	movslq	%edx, %rdx
               	addq	$0x9, %rdx
               	movslq	%edx, %rdx
               	movq	%r11, %rsi
               	subq	$0x2, %rsi
               	movslq	%esi, %rsi
               	subq	$0x5, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %rdi
               	andq	$0x3f, %rdi
               	movq	%r11, %r8
               	orq	$0x3, %r8
               	xorq	$0x3, %r11
               	movslq	%eax, %r9
               	movslq	%ecx, %rax
               	addq	%rax, %r9
               	movslq	%r9d, %rcx
               	movslq	%edx, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%esi, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edi, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r11d, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0x53, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
