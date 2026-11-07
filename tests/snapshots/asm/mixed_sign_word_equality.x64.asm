
mixed_sign_word_equality.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<u>:
               	movq	%rdi, %rax
               	retq

<s>:
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	callq	<addr>
               	cmpl	$0x51, %r12d
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx,%rbx,4), %esi
               	cmpl	$0x51, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	cmpl	$-0x1, %r12d
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	(%rcx,%rbx,4), %esi
               	cmpl	$-0x1, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	cmpl	$-0x1, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	(%rcx,%rbx,4), %esi
               	cmpl	$-0x1, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	movl	(%rcx,%rbx,4), %ecx
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	cmpl	$0x80000000, %r12d      # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx,%rbx,4), %ecx
               	cmpl	$0x80000000, %ecx       # imm = 0x80000000
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x6, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
