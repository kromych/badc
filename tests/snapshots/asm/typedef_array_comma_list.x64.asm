
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
               	addq	$0x78, %r11
               	movq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x78, %r11
               	movq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x10, %r11
               	movq	(%r11), %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x78, %r11
               	movq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x9, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xa, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x138, %r11            # imm = 0x138
               	movl	$0x2a, %eax
               	movq	%rax, (%r11)
               	leaq	<rip>, %r9
               	addq	$0x1f8, %r9             # imm = 0x1F8
               	movabsq	$-0x1, %rax
               	movq	%rax, (%r9)
               	movq	(%r11), %r11
               	cmpq	$0x2a, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x1f8, %r11            # imm = 0x1F8
               	movq	(%r11), %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %r11
               	addq	$0x200, %r11            # imm = 0x200
               	movl	$0x63, %eax
               	movl	%eax, (%r11)
               	leaq	-0x208(%rbp), %rdi
               	addq	$0x200, %rdi            # imm = 0x200
               	movslq	(%rdi), %rdi
               	cmpq	$0x63, %rdi
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x10, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
