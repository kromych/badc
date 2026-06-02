
typedef_array_outer_dim.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movq	%r9, -0x18(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %r9
               	cmpq	$0x10, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %r8
               	shlq	$0x7, %r8
               	addq	%r11, %r8
               	movslq	-0x10(%rbp), %rdi
               	movq	%rdi, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r8
               	shlq	$0x4, %r9
               	movslq	%r9d, %r9
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movq	%r9, (%r8)
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi), %r9
               	movslq	-0x8(%rbp), %r8
               	shlq	$0x7, %r8
               	addq	%r11, %r8
               	movslq	-0x10(%rbp), %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r8
               	movq	(%r8), %r8
               	addq	%r8, %r9
               	movq	%r9, (%rdi)
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	jmp	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, -0x208(%rbp)
               	movl	%r11d, -0x210(%rbp)
               	jmp	<addr>
               	movslq	-0x210(%rbp), %r11
               	cmpq	$0x40, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x210(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	leaq	-0x208(%rbp), %r11
               	movq	(%r11), %r8
               	movslq	-0x210(%rbp), %r9
               	addq	%r9, %r8
               	movq	%r8, (%r11)
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rdi
               	callq	<addr>
               	movq	-0x208(%rbp), %rdi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	addq	$0x1f8, %rax            # imm = 0x1F8
               	movq	(%rax), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	addq	$0xb8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
