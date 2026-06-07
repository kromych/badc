
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	cmpq	$0x4, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	%esi, %rdx
               	cmpq	$0x10, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rsi
               	addq	$0x1, %rsi
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %r8
               	shlq	$0x7, %r8
               	movq	%rdi, %r11
               	addq	%r8, %r11
               	movslq	%esi, %r8
               	movq	%r8, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r11
               	shlq	$0x4, %rdx
               	movslq	%edx, %rdx
               	addq	%r8, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%r11)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	movq	%rdi, %r8
               	addq	%rdx, %r8
               	movslq	%esi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x230, %rsp            # imm = 0x230
               	movq	%rbx, (%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rbx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	%rax, %rbx
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rcx
               	addq	$0x1f8, %rcx            # imm = 0x1F8
               	movq	(%rcx), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rcx
               	addq	$0xb8, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
