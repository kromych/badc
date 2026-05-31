
typedef_array_comma_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	leaq	<rip>, %r11
               	movq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x78, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r9
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x78, %rax
               	movq	(%rax), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r9
               	cmpq	$0x7, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	addq	$0x78, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %eax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x200, %rax            # imm = 0x200
               	je	<addr>
               	movl	$0x9, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %eax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x200, %rax            # imm = 0x200
               	je	<addr>
               	movl	$0xa, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x138, %rax            # imm = 0x138
               	movl	$0x2a, %r9d
               	movq	%r9, (%rax)
               	leaq	<rip>, %r8
               	addq	$0x1f8, %r8             # imm = 0x1F8
               	movabsq	$-0x1, %r9
               	movq	%r9, (%r8)
               	movq	(%rax), %rdi
               	cmpq	$0x2a, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	addq	$0x1f8, %rdi            # imm = 0x1F8
               	movq	(%rdi), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %edi
               	movq	%rdi, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rax
               	addq	$0x200, %rax            # imm = 0x200
               	movl	$0x63, %edi
               	movl	%edi, (%rax)
               	leaq	-0x208(%rbp), %r9
               	addq	$0x200, %r9             # imm = 0x200
               	movslq	(%r9), %rdi
               	cmpq	$0x63, %rdi
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %edi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	addq	$0x4, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x208, %rdi            # imm = 0x208
               	jle	<addr>
               	movl	$0x10, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
