
quicksort.x64:	file format elf64-x86-64

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

<swap>:
               	movl	(%rdi), %eax
               	movl	(%rsi), %ecx
               	movl	%ecx, (%rdi)
               	movl	%eax, (%rsi)
               	retq

<partition>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movl	(%rdi,%rdx,4), %r8d
               	leaq	-0x1(%rsi), %rax
               	jmp	<addr>
               	incq	%rsi
               	cmpl	%edx, %esi
               	jge	<addr>
               	movl	(%rdi,%rsi,4), %ecx
               	cmpl	%r8d, %ecx
               	jg	<addr>
               	incq	%rax
               	movl	(%rdi,%rax,4), %r9d
               	movl	%ecx, (%rdi,%rax,4)
               	movl	%r9d, (%rdi,%rsi,4)
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rcx
               	movl	(%rdi,%rcx,4), %esi
               	movl	(%rdi,%rdx,4), %r8d
               	movl	%r8d, (%rdi,%rcx,4)
               	movl	%esi, (%rdi,%rdx,4)
               	retq

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movslq	%esi, %rcx
               	movslq	%edx, %rdx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	movl	(%rdi,%rdx,4), %r8d
               	leaq	-0x1(%rcx), %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	incq	%rsi
               	cmpl	%edx, %esi
               	jge	<addr>
               	movl	(%rdi,%rsi,4), %r9d
               	cmpl	%r8d, %r9d
               	jg	<addr>
               	incq	%rax
               	movl	(%rdi,%rax,4), %r9d
               	movl	(%rdi,%rsi,4), %ebx
               	movl	%ebx, (%rdi,%rax,4)
               	movl	%r9d, (%rdi,%rsi,4)
               	jmp	<addr>
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	movl	(%rdi,%rax,4), %esi
               	movl	(%rdi,%rdx,4), %r8d
               	movl	%r8d, (%rdi,%rax,4)
               	movl	%esi, (%rdi,%rdx,4)
               	leaq	-0x1(%rbx), %rax
               	movq	%rdi, 0x18(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rcx, %rsi
               	movq	%rax, %rdx
               	callq	<addr>
               	movq	0x18(%rsp), %rdi
               	movq	0x10(%rsp), %rdx
               	leaq	0x1(%rbx), %rsi
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x14, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%esi, %esi
               	movabsq	$0x70000000c, %rax      # imm = 0x70000000C
               	movl	$0x4, %edx
               	movq	%rax, (%rbx)
               	movabsq	$0x50000000f, %rax      # imm = 0x50000000F
               	movq	%rax, 0x8(%rbx)
               	movl	$0xa, 0x10(%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	(%rbx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x4(%rbx), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x8(%rbx), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0xc(%rbx), %eax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x10(%rbx), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
