
inline_asm_a64_fp_vector.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x41a80000, %eax       # imm = 0x41A80000
               	leaq	-0x8(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movzbq	(%rsi), %rax
               	movb	%al, (%rdx)
               	movzbq	0x1(%rsi), %rax
               	movb	%al, 0x1(%rdx)
               	movzbq	0x2(%rsi), %rax
               	movb	%al, 0x2(%rdx)
               	movzbq	0x3(%rsi), %rax
               	movb	%al, 0x3(%rdx)
               	popq	%rax
               	leaq	-0x8(%rbp), %rdx
               	movl	%eax, (%rdx)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x8(%rbp), %rdx
               	movss	(%rdx,%riz), %xmm0
               	leaq	-0x8(%rbp), %rdx
               	movss	(%rdx,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	movl	$0x42280000, %eax       # imm = 0x42280000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
