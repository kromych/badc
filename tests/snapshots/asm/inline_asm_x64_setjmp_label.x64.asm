
inline_asm_x64_setjmp_label.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<ctx_jump>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %rbp
               	movq	0x10(%rax), %r12
               	movq	0x18(%rax), %rdx
               	movq	0x20(%rax), %r13
               	movq	0x28(%rax), %r14
               	movq	%rdx, %rsp
               	movq	0x30(%rax), %r15
               	movq	0x38(%rax), %rdx
               	jmpq	*%rdx
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rdx
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8860, %rsp           # imm = 0x8860
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %r8
               	movq	%rax, -0x8860(%rbp)
               	movq	%rcx, -0x8858(%rbp)
               	movq	%rdx, -0x8850(%rbp)
               	movq	%r8, -0x8848(%rbp)
               	movq	%r9, -0x8840(%rbp)
               	movq	%r10, -0x8838(%rbp)
               	movq	%r11, -0x8830(%rbp)
               	movq	%rax, -0x8828(%rbp)
               	movq	%r8, -0x8820(%rbp)
               	movq	-0x8820(%rbp), %rdx
               	leaq	<rip>, %rcx        # <addr>
               	xorq	%rax, %rax
               	movq	%rbx, (%rdx)
               	movq	%rbp, 0x8(%rdx)
               	movq	%r12, 0x10(%rdx)
               	movq	%rsp, 0x18(%rdx)
               	movq	%r13, 0x20(%rdx)
               	movq	%r14, 0x28(%rdx)
               	movq	%r15, 0x30(%rdx)
               	movq	%rcx, 0x38(%rdx)
               	movq	-0x8828(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x8860(%rbp), %rax
               	movq	-0x8858(%rbp), %rcx
               	movq	-0x8850(%rbp), %rdx
               	movq	-0x8848(%rbp), %r8
               	movq	-0x8840(%rbp), %r9
               	movq	-0x8838(%rbp), %r10
               	movq	-0x8830(%rbp), %r11
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x8860, %rsp           # imm = 0x8860
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x110(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x4(%rcx), %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x220(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x3(%rcx), %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x330(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x2(%rcx), %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x440(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x550(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	(%rcx), %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jl	<addr>
               	leaq	-0x550(%rbp), %rax
               	movsbq	(%rax), %rax
               	leaq	-0x440(%rbp), %rax
               	movsbq	(%rax), %rax
               	leaq	-0x330(%rbp), %rax
               	movsbq	(%rax), %rax
               	leaq	-0x220(%rbp), %rax
               	movsbq	(%rax), %rax
               	leaq	-0x110(%rbp), %rax
               	movsbq	(%rax), %rax
               	movq	%r8, %rdi
               	callq	<addr>
               	movl	$0x2, %eax
               	addq	$0x8860, %rsp           # imm = 0x8860
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x8860, %rsp           # imm = 0x8860
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x8860, %rsp           # imm = 0x8860
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
