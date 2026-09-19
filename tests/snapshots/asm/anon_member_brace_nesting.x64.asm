
anon_member_brace_nesting.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movsbq	(%rdx), %rcx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rdx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rdx), %rsi
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rdx), %rcx
               	movsbq	0x10(%rax), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movsbq	(%rdx), %rcx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x8(%rdx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0xc(%rdx), %rsi
               	movslq	0xc(%rax), %rdi
               	cmpl	%edi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	0x10(%rdx), %rdx
               	movsbq	0x10(%rax), %rax
               	cmpl	%eax, %edx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	movsbq	(%rax), %rsi
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	movsbq	0x4(%rdx), %rsi
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%esi, %esi
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x8(%rax), %rcx
               	movsbq	0x8(%rdx), %rdi
               	cmpl	%edi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0xc(%rax), %rcx
               	movslq	0xc(%rdx), %rdi
               	cmpl	%edi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x10(%rax), %rax
               	movsbq	0x10(%rdx), %rcx
               	cmpl	%ecx, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movsbq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	cmpl	$0x11111111, %ecx       # imm = 0x11111111
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x22222222, %ecx       # imm = 0x22222222
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzbq	0x8(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x10(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	movslq	0x10(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
