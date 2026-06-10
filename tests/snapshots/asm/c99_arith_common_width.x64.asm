
c99_arith_common_width.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x300, %esi            # imm = 0x300
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
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
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	incq	%rax
               	movl	%eax, %eax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	decq	%rax
               	movl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1a, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ecx
               	subq	%rcx, %rax
               	movl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x2, %ebx
               	movl	%ebx, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x21, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	$0xfffffffe, %r13d      # imm = 0xFFFFFFFE
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ecx
               	imulq	%rcx, %rax
               	movl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x3, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x29, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xc350, %eax           # imm = 0xC350
               	imulq	%rax, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x4, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x31, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x6afd0700, %rax      # imm = 0x9502F900
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x5, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3e, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ecx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x64, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4b, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	%rcx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x65, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x54, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x66, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5d, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
