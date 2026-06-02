
comma_operator_in_loops.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rax
               	leaq	<rip>, %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0xa, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %rax
               	addq	$0x64, %rax
               	movl	%eax, (%rdi)
               	jmp	<addr>
               	movl	$0x7, %r9d
               	movq	%r9, %rdi
               	callq	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r9)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x3e8, %r9             # imm = 0x3E8
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdi
               	addq	$0x1869f, %rdi          # imm = 0x1869F
               	movl	%edi, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rdi)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x7, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rdi
               	subq	$0x456, %rdi            # imm = 0x456
               	movslq	%edi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
