
switch_nested_case_in_compound.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x2, %r9d
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x7, %r8
               	je	<addr>
               	jmp	<addr>
               	movl	$0x64, %r8d
               	movl	%r8d, -0x18(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movslq	-0x18(%rbp), %r11
               	addq	%r11, %r8
               	movl	%r8d, (%r9)
               	movslq	-0x18(%rbp), %r9
               	cmpq	$0x64, %r9
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x2, %r11
               	movl	%r11d, (%r9)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x4, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	orq	$0x4000, %r9            # imm = 0x4000
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	cmpq	$0x1, %r9
               	je	<addr>
               	cmpq	$0x2, %r9
               	je	<addr>
               	cmpq	$0x3, %r9
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	orq	$0x1000, %r9            # imm = 0x1000
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r11
               	orq	$0x2000, %r11           # imm = 0x2000
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x8(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	%esi, -0x8(%rbp)
               	movl	$0x1, %eax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdi
               	cmpq	$0x106b, %rdi           # imm = 0x106B
               	je	<addr>
               	jmp	<addr>
               	movl	$0x64, %edi
               	movl	%edi, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdi
               	movslq	-0x20(%rbp), %rsi
               	addq	%rsi, %rdi
               	movl	%edi, (%rax)
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rsi
               	addq	$0x2, %rsi
               	movl	%esi, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdi
               	addq	$0x4, %rdi
               	movl	%edi, (%rax)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %rsi
               	orq	$0x2000, %rsi           # imm = 0x2000
               	movl	%esi, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movslq	-0x8(%rbp), %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
