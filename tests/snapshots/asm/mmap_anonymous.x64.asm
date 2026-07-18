
mmap_anonymous.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x4000, %ebx           # imm = 0x4000
               	xorq	%rdi, %rdi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movabsq	$-0x1, %r8
               	movq	%rbx, %rsi
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdx
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rdx), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	0x1000(%rdx), %rax
               	movl	$0x2, %ecx
               	movb	%cl, (%rax)
               	leaq	0x2000(%rdx), %rax
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	leaq	0x3000(%rdx), %rax
               	movl	$0x4, %ecx
               	movb	%cl, (%rax)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rax), %rcx
               	movsbq	(%rcx), %rsi
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	incq	%rcx
               	movsbq	%cl, %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	addq	$0x1000, %rax           # imm = 0x1000
               	cmpq	%rbx, %rax
               	jb	<addr>
               	movq	%rdx, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
