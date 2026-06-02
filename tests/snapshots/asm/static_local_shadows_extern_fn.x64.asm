
static_local_shadows_extern_fn.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movzbq	(%rdi), %r9
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r9
               	movzbq	(%r9), %rax
               	addq	$0x1, %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
