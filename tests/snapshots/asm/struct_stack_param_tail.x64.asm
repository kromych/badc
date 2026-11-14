
struct_stack_param_tail.x64:	file format elf64-x86-64

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

<sum20>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movl	0x20(%rbp), %r10d
               	movl	%r10d, -0x8(%rbp)
               	movss	-0x18(%rbp), %xmm0
               	movss	-0x14(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	leave
               	retq

<sum_bytes>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	movsbq	(%rdi,%rax), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<sum22>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movl	0x20(%rbp), %r10d
               	movl	%r10d, -0x8(%rbp)
               	movzwq	0x24(%rbp), %r10
               	movw	%r10w, -0x4(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x16, %esi
               	callq	<addr>
               	leave
               	retq

<sum23>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movl	0x20(%rbp), %r10d
               	movl	%r10d, -0x8(%rbp)
               	movzwq	0x24(%rbp), %r10
               	movw	%r10w, -0x4(%rbp)
               	movzbq	0x26(%rbp), %r10
               	movb	%r10b, -0x2(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x17, %esi
               	callq	<addr>
               	leave
               	retq

<sum17>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movzbq	0x20(%rbp), %r10
               	movb	%r10b, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x11, %esi
               	callq	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0x10(%rcx), %r10d
               	movl	%r10d, 0x10(%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x17, %eax
               	jge	<addr>
               	cmpl	$0x16, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rdx
               	movb	%dl, -0x48(%rbp,%rax)
               	movq	%rax, %rdx
               	shlq	%rdx
               	incq	%rdx
               	movb	%dl, -0x30(%rbp,%rax)
               	cmpl	$0x11, %eax
               	jge	<addr>
               	movl	$0x28, %edx
               	subq	%rax, %rdx
               	movb	%dl, -0x18(%rbp,%rax)
               	jmp	<addr>
               	leaq	-0x60(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movzbq	0x10(%r10), %r11
               	movb	%r11b, 0x10(%rsp)
               	movzbq	0x11(%r10), %r11
               	movb	%r11b, 0x11(%rsp)
               	movzbq	0x12(%r10), %r11
               	movb	%r11b, 0x12(%rsp)
               	movzbq	0x13(%r10), %r11
               	movb	%r11b, 0x13(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movss	<rip>, %xmm1
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	ucomiss	%xmm1, %xmm0
               	movq	%rax, %r10
               	cmovpq	%rbx, %r10
               	cmoveq	%r10, %rbx
               	leaq	-0x48(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movzbq	0x10(%r10), %r11
               	movb	%r11b, 0x10(%rsp)
               	movzbq	0x11(%r10), %r11
               	movb	%r11b, 0x11(%rsp)
               	movzbq	0x12(%r10), %r11
               	movb	%r11b, 0x12(%rsp)
               	movzbq	0x13(%r10), %r11
               	movb	%r11b, 0x13(%rsp)
               	movzbq	0x14(%r10), %r11
               	movb	%r11b, 0x14(%rsp)
               	movzbq	0x15(%r10), %r11
               	movb	%r11b, 0x15(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %r12
               	leaq	-0x48(%rbp), %rdi
               	movl	$0x16, %esi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpl	%eax, %r12d
               	cmovneq	%rcx, %rbx
               	leaq	-0x30(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movzbq	0x10(%r10), %r11
               	movb	%r11b, 0x10(%rsp)
               	movzbq	0x11(%r10), %r11
               	movb	%r11b, 0x11(%rsp)
               	movzbq	0x12(%r10), %r11
               	movb	%r11b, 0x12(%rsp)
               	movzbq	0x13(%r10), %r11
               	movb	%r11b, 0x13(%rsp)
               	movzbq	0x14(%r10), %r11
               	movb	%r11b, 0x14(%rsp)
               	movzbq	0x15(%r10), %r11
               	movb	%r11b, 0x15(%rsp)
               	movzbq	0x16(%r10), %r11
               	movb	%r11b, 0x16(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %r12
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x17, %esi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpl	%eax, %r12d
               	cmovneq	%rcx, %rbx
               	leaq	-0x18(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movzbq	0x10(%r10), %r11
               	movb	%r11b, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %r12
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x11, %esi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpl	%eax, %r12d
               	cmoveq	%rbx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
