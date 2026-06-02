
typedef_array_param_decay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x10, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	addq	%rsi, %r8
               	movq	(%r8), %r8
               	movq	%r8, (%r9)
               	jmp	<addr>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r9, %r9
               	movq	%r9, -0x10(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x10, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r9
               	movq	(%r9), %r11
               	movslq	-0x8(%rbp), %r8
               	shlq	$0x3, %r8
               	addq	%rdi, %r8
               	movq	(%r8), %r8
               	addq	%r8, %r11
               	movq	%r11, (%r9)
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	xorq	%r11, %r11
               	movl	%r11d, -0x108(%rbp)
               	jmp	<addr>
               	movslq	-0x108(%rbp), %r11
               	cmpq	$0x10, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x108(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	leaq	-0x80(%rbp), %r11
               	movslq	-0x108(%rbp), %r8
               	movq	%r8, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r11
               	addq	$0x1, %r8
               	movq	%r8, (%r11)
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	callq	<addr>
               	movl	$0x110, %edi            # imm = 0x110
               	movl	$0x2, %esi
               	movq	%rsi, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	addq	$0x78, %rax
               	movq	(%rax), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
