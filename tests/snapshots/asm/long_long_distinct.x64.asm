
long_long_distinct.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	jmp	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	movabsq	$0x123456789abcdef, %r10 # imm = 0x123456789ABCDEF
               	cmpq	%r10, %r11
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x7, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %r11d
               	movl	$0xc8, %r9d
               	addq	%r9, %r11
               	cmpq	$0x12c, %r11            # imm = 0x12C
               	je	<addr>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r11
               	movl	$0xa, %r9d
               	movq	%r9, (%r11)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x14, %r9d
               	movq	%r9, (%r8)
               	leaq	-0x40(%rbp), %r11
               	addq	$0x10, %r11
               	movl	$0x1e, %r9d
               	movq	%r9, (%r11)
               	leaq	-0x40(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x14, %r9
               	je	<addr>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addq	$0x10, %r8
               	movq	(%r8), %r8
               	cmpq	$0x1e, %r8
               	je	<addr>
               	movl	$0xa, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %r8
               	movl	$0x64, %r9d
               	movq	%r9, (%r8)
               	leaq	-0x60(%rbp), %r11
               	addq	$0x8, %r11
               	movl	$0xc8, %r9d
               	movq	%r9, (%r11)
               	leaq	-0x60(%rbp), %r8
               	addq	$0x10, %r8
               	movl	$0x12c, %r9d            # imm = 0x12C
               	movq	%r9, (%r8)
               	leaq	-0x60(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r9
               	cmpq	$0xc8, %r9
               	je	<addr>
               	movl	$0xb, %r8d
               	movq	%r8, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addq	$0x10, %r11
               	movq	(%r11), %r11
               	cmpq	$0x12c, %r11            # imm = 0x12C
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
