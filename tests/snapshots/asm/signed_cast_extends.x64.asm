
signed_cast_extends.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
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
               	subq	$0xd0, %rsp
               	movl	$0xff, %r11d
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %r11d
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x80, %r11
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %r11d
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x7f, %r11
               	je	<addr>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %r11d
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x78, %r11
               	je	<addr>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234abff, %r11d      # imm = 0x1234ABFF
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %r11d          # imm = 0xFFFF
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x7, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %r11d          # imm = 0x8000
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x8000, %r11          # imm = 0x8000
               	je	<addr>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x5678, %r11           # imm = 0x5678
               	je	<addr>
               	movl	$0x9, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234ffff, %r11d      # imm = 0x1234FFFF
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0xa, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2a, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x2a, %r11
               	je	<addr>
               	movl	$0xb, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %r11
               	movl	$0xff, %r9d
               	movb	%r9b, (%r11)
               	leaq	-0xb8(%rbp), %r8
               	addq	$0x1, %r8
               	movl	$0x42, %r9d
               	movb	%r9b, (%r8)
               	leaq	-0xb8(%rbp), %r11
               	addq	$0x2, %r11
               	movl	$0x10, %r9d
               	movb	%r9b, (%r11)
               	leaq	-0xb8(%rbp), %r8
               	movzbq	(%r8), %r8
               	movsbq	%r8b, %r8
               	movslq	%r8d, %r8
               	cmpq	$-0x1, %r8
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %r8
               	movzbq	(%r8), %r8
               	movsbq	%r8b, %r8
               	shlq	$0x8, %r8
               	movslq	%r8d, %r8
               	leaq	-0xb8(%rbp), %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %r9
               	orq	%r9, %r8
               	movslq	%r8d, %r8
               	cmpq	$-0xbe, %r8
               	je	<addr>
               	movl	$0xd, %r9d
               	movq	%r9, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
