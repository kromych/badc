
aggregate_result_alignment.x64:	file format elf64-x86-64

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

<make_m16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movsbq	%sil, %rsi
               	leaq	-0x40(%rbp), %rcx
               	andq	$0xff, %rsi
               	movb	%sil, -0x40(%rbp)
               	movb	%sil, -0x3f(%rbp)
               	movb	%sil, -0x3e(%rbp)
               	movb	%sil, -0x3d(%rbp)
               	movb	%sil, -0x3c(%rbp)
               	movb	%sil, -0x3b(%rbp)
               	movb	%sil, -0x3a(%rbp)
               	movb	%sil, -0x39(%rbp)
               	movb	%sil, -0x38(%rbp)
               	movb	%sil, -0x37(%rbp)
               	movb	%sil, -0x36(%rbp)
               	movb	%sil, -0x35(%rbp)
               	movb	%sil, -0x34(%rbp)
               	movb	%sil, -0x33(%rbp)
               	movb	%sil, -0x32(%rbp)
               	movb	%sil, -0x31(%rbp)
               	movb	%sil, -0x30(%rbp)
               	movb	%sil, -0x2f(%rbp)
               	movb	%sil, -0x2e(%rbp)
               	movb	%sil, -0x2d(%rbp)
               	movb	%sil, -0x2c(%rbp)
               	movb	%sil, -0x2b(%rbp)
               	movb	%sil, -0x2a(%rbp)
               	movb	%sil, -0x29(%rbp)
               	movb	%sil, -0x28(%rbp)
               	movb	%sil, -0x27(%rbp)
               	movb	%sil, -0x26(%rbp)
               	movb	%sil, -0x25(%rbp)
               	movb	%sil, -0x24(%rbp)
               	movb	%sil, -0x23(%rbp)
               	movb	%sil, -0x22(%rbp)
               	movb	%sil, -0x21(%rbp)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<results>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movsbq	%dil, %rbx
               	leaq	0x80(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	leaq	0xa0(%rsp), %rdx
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0xa0(%rsp)
               	movb	%al, 0xa1(%rsp)
               	movb	%al, 0xa2(%rsp)
               	movb	%al, 0xa3(%rsp)
               	movb	%al, 0xa4(%rsp)
               	movb	%al, 0xa5(%rsp)
               	movb	%al, 0xa6(%rsp)
               	movb	%al, 0xa7(%rsp)
               	movb	%al, 0xa8(%rsp)
               	movb	%al, 0xa9(%rsp)
               	movb	%al, 0xaa(%rsp)
               	movb	%al, 0xab(%rsp)
               	movb	%al, 0xac(%rsp)
               	movb	%al, 0xad(%rsp)
               	movb	%al, 0xae(%rsp)
               	movb	%al, 0xaf(%rsp)
               	andq	$0xf, %rdx
               	leaq	(%rcx,%rdx), %r12
               	leaq	(%rsp), %rdi
               	movl	$0x40, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	addq	%r12, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x3e8, %rax            # imm = 0x3E8
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	0xb0(%rsp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movsbq	0xcf(%rsp), %rax
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movsbq	%cl, %rcx
               	leaq	(%rax,%rcx), %r12
               	leaq	0x40(%rsp), %rdi
               	movl	$0x40, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsbq	0x7f(%rsp), %rax
               	addq	%r12, %rax
               	leaq	(%rbx,%rbx,2), %rcx
               	subq	%rcx, %rax
               	jmp	<addr>

<probe_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %r12
               	movsbq	%sil, %rbx
               	movq	%r12, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r13
               	subq	%r11, %r13
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r13, %rsp
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x20(%rbp)
               	movb	%al, -0x1f(%rbp)
               	movb	%al, -0x1e(%rbp)
               	movb	%al, -0x1d(%rbp)
               	movb	%al, -0x1c(%rbp)
               	movb	%al, -0x1b(%rbp)
               	movb	%al, -0x1a(%rbp)
               	movb	%al, -0x19(%rbp)
               	movb	%al, -0x18(%rbp)
               	movb	%al, -0x17(%rbp)
               	movb	%al, -0x16(%rbp)
               	movb	%al, -0x15(%rbp)
               	movb	%al, -0x14(%rbp)
               	movb	%al, -0x13(%rbp)
               	movb	%al, -0x12(%rbp)
               	movb	%al, -0x11(%rbp)
               	andq	$0xf, %rdx
               	leaq	(%rcx,%rdx), %rax
               	leaq	-0x1(%r12), %rcx
               	movslq	%ecx, %rcx
               	movsbq	(%r13,%rcx), %rcx
               	addq	%rcx, %rax
               	subq	%rbx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	andq	$-0x20, %rsp
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	%rdi, -0x30(%rbp)
               	callq	<addr>
               	movq	-0x30(%rbp), %rcx
               	subq	$0x2, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	0x100(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	leaq	0x100(%rsp), %rax
               	andq	$0xf, %rax
               	leaq	(%rbx,%rax), %rcx
               	leaq	0x120(%rsp), %rdx
               	movl	$0x2, %eax
               	movb	%al, 0x120(%rsp)
               	movb	%al, 0x121(%rsp)
               	movb	%al, 0x122(%rsp)
               	movb	%al, 0x123(%rsp)
               	movb	%al, 0x124(%rsp)
               	movb	%al, 0x125(%rsp)
               	movb	%al, 0x126(%rsp)
               	movb	%al, 0x127(%rsp)
               	movb	%al, 0x128(%rsp)
               	movb	%al, 0x129(%rsp)
               	movb	%al, 0x12a(%rsp)
               	movb	%al, 0x12b(%rsp)
               	movb	%al, 0x12c(%rsp)
               	movb	%al, 0x12d(%rsp)
               	movb	%al, 0x12e(%rsp)
               	movb	%al, 0x12f(%rsp)
               	andq	$0xf, %rdx
               	addq	%rdx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %esi
               	movq	%rsi, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	leaq	(%rsp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movq	%rax, %rbx
               	andq	$0x1f, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	-0x28(%rbp), %rcx
               	movq	-0x20(%rbp), %rdx
               	subq	%rdx, %rcx
               	leaq	(%rax,%rcx), %r12
               	leaq	0x130(%rsp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	0x130(%rsp), %rax
               	andq	$0xf, %rax
               	addq	%r12, %rax
               	leaq	0x150(%rsp), %rcx
               	movl	$0x3, %esi
               	movb	%sil, 0x150(%rsp)
               	movb	%sil, 0x151(%rsp)
               	movb	%sil, 0x152(%rsp)
               	movb	%sil, 0x153(%rsp)
               	movb	%sil, 0x154(%rsp)
               	movb	%sil, 0x155(%rsp)
               	movb	%sil, 0x156(%rsp)
               	movb	%sil, 0x157(%rsp)
               	movb	%sil, 0x158(%rsp)
               	movb	%sil, 0x159(%rsp)
               	movb	%sil, 0x15a(%rsp)
               	movb	%sil, 0x15b(%rsp)
               	movb	%sil, 0x15c(%rsp)
               	movb	%sil, 0x15d(%rsp)
               	movb	%sil, 0x15e(%rsp)
               	movb	%sil, 0x15f(%rsp)
               	andq	$0xf, %rcx
               	leaq	(%rax,%rcx), %r12
               	leaq	0x40(%rsp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	andq	$0x1f, %rax
               	addq	%r12, %rax
               	imulq	$0x64, %rbx, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	0x80(%rsp), %rdi
               	movl	$0x3, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movsbq	0x85(%rsp), %rax
               	addq	%rbx, %rax
               	subq	$0x3, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x4, %esi
               	movq	%rsi, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	shlq	%rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	0x160(%rsp), %rdi
               	callq	<addr>
               	leaq	0x160(%rsp), %rax
               	andq	$0xf, %rax
               	addq	%rbx, %rax
               	leaq	0x180(%rsp), %rcx
               	movl	$0x4, %esi
               	movb	%sil, 0x180(%rsp)
               	movb	%sil, 0x181(%rsp)
               	movb	%sil, 0x182(%rsp)
               	movb	%sil, 0x183(%rsp)
               	movb	%sil, 0x184(%rsp)
               	movb	%sil, 0x185(%rsp)
               	movb	%sil, 0x186(%rsp)
               	movb	%sil, 0x187(%rsp)
               	movb	%sil, 0x188(%rsp)
               	movb	%sil, 0x189(%rsp)
               	movb	%sil, 0x18a(%rsp)
               	movb	%sil, 0x18b(%rsp)
               	movb	%sil, 0x18c(%rsp)
               	movb	%sil, 0x18d(%rsp)
               	movb	%sil, 0x18e(%rsp)
               	movb	%sil, 0x18f(%rsp)
               	andq	$0xf, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	0xc0(%rsp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0xc0(%rsp), %rax
               	andq	$0x1f, %rax
               	addq	%rbx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x5, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x6, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
