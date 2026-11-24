
struct_stack_param_tail.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movl	0x40(%rsp), %r10d
               	movl	%r10d, 0x18(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movss	0xc(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x10(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x14(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x18(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	addq	$0x28, %rsp
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
               	nopl	(%rax,%rax)
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<sum22>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movl	0x40(%rsp), %r10d
               	movl	%r10d, 0x18(%rsp)
               	movzwq	0x44(%rsp), %r10
               	movw	%r10w, 0x1c(%rsp)
               	leaq	0x8(%rsp), %rdi
               	movl	$0x16, %esi
               	callq	<addr>
               	addq	$0x28, %rsp
               	retq

<sum23>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movl	0x40(%rsp), %r10d
               	movl	%r10d, 0x18(%rsp)
               	movzwq	0x44(%rsp), %r10
               	movw	%r10w, 0x1c(%rsp)
               	movzbq	0x46(%rsp), %r10
               	movb	%r10b, 0x1e(%rsp)
               	leaq	0x8(%rsp), %rdi
               	movl	$0x17, %esi
               	callq	<addr>
               	addq	$0x28, %rsp
               	retq

<sum17>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movzbq	0x40(%rsp), %r10
               	movb	%r10b, 0x18(%rsp)
               	leaq	0x8(%rsp), %rdi
               	movl	$0x11, %esi
               	callq	<addr>
               	addq	$0x28, %rsp
               	retq

<main>:
               	subq	$0x68, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	leaq	0x30(%rsp), %rax
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
               	movb	%dl, 0x48(%rsp,%rax)
               	movq	%rax, %rdx
               	shlq	%rdx
               	incq	%rdx
               	movb	%dl, 0x60(%rsp,%rax)
               	cmpl	$0x11, %eax
               	jge	<addr>
               	movl	$0x28, %edx
               	subq	%rax, %rdx
               	movb	%dl, 0x78(%rsp,%rax)
               	nop
               	jmp	<addr>
               	leaq	0x30(%rsp), %r9
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
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	ucomiss	<rip>, %xmm0
               	movq	%rax, %r10
               	cmovpq	%rbx, %r10
               	cmoveq	%r10, %rbx
               	leaq	0x48(%rsp), %r9
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
               	movq	%rax, %r12
               	leaq	0x48(%rsp), %rdi
               	movl	$0x16, %esi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpl	%eax, %r12d
               	cmovneq	%rcx, %rbx
               	leaq	0x60(%rsp), %r9
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
               	movq	%rax, %r12
               	leaq	0x60(%rsp), %rdi
               	movl	$0x17, %esi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpl	%eax, %r12d
               	cmovneq	%rcx, %rbx
               	leaq	0x78(%rsp), %r9
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movzbq	0x10(%r10), %r11
               	movb	%r11b, 0x10(%rsp)
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	0x78(%rsp), %rdi
               	movl	$0x11, %esi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpl	%eax, %r12d
               	cmoveq	%rbx, %rcx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x68, %rsp
               	retq
