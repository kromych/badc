
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
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	shlq	$0x4, %r9
               	movslq	%r9d, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%r9, (%rdi)
               	leaq	-0x18(%rbp), %r8
               	movq	(%r8), %r9
               	movslq	-0x8(%rbp), %rdi
               	shlq	$0x7, %rdi
               	movq	%r11, %rsi
               	addq	%rdi, %rsi
               	movslq	-0x10(%rbp), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %rdi
               	addq	%rdi, %r9
               	movq	%r9, (%r8)
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x230, %rsp            # imm = 0x230
               	movq	%rbx, (%rsp)
               	movl	$0x40, %r11d
               	movslq	%r11d, %r11
               	shlq	$0x3, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, -0x208(%rbp)
               	movl	%r11d, -0x210(%rbp)
               	jmp	<addr>
               	movslq	-0x210(%rbp), %r11
               	movl	$0x40, %r9d
               	movslq	%r9d, %r9
               	cmpq	%r9, %r11
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
               	leaq	-0x200(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	-0x208(%rbp), %rbx
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	(%rax), %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rbx
               	addq	$0x1f8, %rbx            # imm = 0x1F8
               	movq	(%rbx), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	addq	$0xb8, %rax
               	movq	(%rax), %rbx
               	cmpq	$0x17, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
