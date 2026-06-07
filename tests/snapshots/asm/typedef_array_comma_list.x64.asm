
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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	addq	$0x78, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x78, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x78, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x0, %rax
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
               	leaq	<rip>, %rcx
               	addq	$0x138, %rcx            # imm = 0x138
               	movl	$0x2a, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rdx
               	addq	$0x1f8, %rdx            # imm = 0x1F8
               	movabsq	$-0x1, %rax
               	movq	%rax, (%rdx)
               	movq	(%rcx), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x1f8, %rcx            # imm = 0x1F8
               	movq	(%rcx), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rax
               	addq	$0x200, %rax            # imm = 0x200
               	movl	$0x63, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x208(%rbp), %rax
               	addq	$0x200, %rax            # imm = 0x200
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
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
               	xorq	%rax, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
