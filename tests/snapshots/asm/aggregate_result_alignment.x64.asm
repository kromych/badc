
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

<results>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movsbq	%dil, %rbx
               	leaq	0x80(%rsp), %rcx
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x80(%rsp)
               	movb	%al, 0x81(%rsp)
               	movb	%al, 0x82(%rsp)
               	movb	%al, 0x83(%rsp)
               	movb	%al, 0x84(%rsp)
               	movb	%al, 0x85(%rsp)
               	movb	%al, 0x86(%rsp)
               	movb	%al, 0x87(%rsp)
               	movb	%al, 0x88(%rsp)
               	movb	%al, 0x89(%rsp)
               	movb	%al, 0x8a(%rsp)
               	movb	%al, 0x8b(%rsp)
               	movb	%al, 0x8c(%rsp)
               	movb	%al, 0x8d(%rsp)
               	movb	%al, 0x8e(%rsp)
               	movb	%al, 0x8f(%rsp)
               	movb	%al, 0x90(%rsp)
               	movb	%al, 0x91(%rsp)
               	movb	%al, 0x92(%rsp)
               	movb	%al, 0x93(%rsp)
               	movb	%al, 0x94(%rsp)
               	movb	%al, 0x95(%rsp)
               	movb	%al, 0x96(%rsp)
               	movb	%al, 0x97(%rsp)
               	movb	%al, 0x98(%rsp)
               	movb	%al, 0x99(%rsp)
               	movb	%al, 0x9a(%rsp)
               	movb	%al, 0x9b(%rsp)
               	movb	%al, 0x9c(%rsp)
               	movb	%al, 0x9d(%rsp)
               	movb	%al, 0x9e(%rsp)
               	movb	%al, 0x9f(%rsp)
               	andq	$0xf, %rcx
               	leaq	0xa0(%rsp), %rdx
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
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	leaq	(%rax,%rax), %r12
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

<probe2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x100, %rsp            # imm = 0x100
               	andq	$-0x20, %rsp
               	movl	$0x3, %esi
               	movq	%rsi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	(%rsp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movq	%rax, %rbx
               	andq	$0x1f, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	subq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0xc0(%rsp), %rcx
               	movl	$0x3, %esi
               	movb	%sil, 0xc0(%rsp)
               	movb	%sil, 0xc1(%rsp)
               	movb	%sil, 0xc2(%rsp)
               	movb	%sil, 0xc3(%rsp)
               	movb	%sil, 0xc4(%rsp)
               	movb	%sil, 0xc5(%rsp)
               	movb	%sil, 0xc6(%rsp)
               	movb	%sil, 0xc7(%rsp)
               	movb	%sil, 0xc8(%rsp)
               	movb	%sil, 0xc9(%rsp)
               	movb	%sil, 0xca(%rsp)
               	movb	%sil, 0xcb(%rsp)
               	movb	%sil, 0xcc(%rsp)
               	movb	%sil, 0xcd(%rsp)
               	movb	%sil, 0xce(%rsp)
               	movb	%sil, 0xcf(%rsp)
               	movb	%sil, 0xd0(%rsp)
               	movb	%sil, 0xd1(%rsp)
               	movb	%sil, 0xd2(%rsp)
               	movb	%sil, 0xd3(%rsp)
               	movb	%sil, 0xd4(%rsp)
               	movb	%sil, 0xd5(%rsp)
               	movb	%sil, 0xd6(%rsp)
               	movb	%sil, 0xd7(%rsp)
               	movb	%sil, 0xd8(%rsp)
               	movb	%sil, 0xd9(%rsp)
               	movb	%sil, 0xda(%rsp)
               	movb	%sil, 0xdb(%rsp)
               	movb	%sil, 0xdc(%rsp)
               	movb	%sil, 0xdd(%rsp)
               	movb	%sil, 0xde(%rsp)
               	movb	%sil, 0xdf(%rsp)
               	andq	$0xf, %rcx
               	addq	%rcx, %rax
               	leaq	0xe0(%rsp), %rcx
               	movb	%sil, 0xe0(%rsp)
               	movb	%sil, 0xe1(%rsp)
               	movb	%sil, 0xe2(%rsp)
               	movb	%sil, 0xe3(%rsp)
               	movb	%sil, 0xe4(%rsp)
               	movb	%sil, 0xe5(%rsp)
               	movb	%sil, 0xe6(%rsp)
               	movb	%sil, 0xe7(%rsp)
               	movb	%sil, 0xe8(%rsp)
               	movb	%sil, 0xe9(%rsp)
               	movb	%sil, 0xea(%rsp)
               	movb	%sil, 0xeb(%rsp)
               	movb	%sil, 0xec(%rsp)
               	movb	%sil, 0xed(%rsp)
               	movb	%sil, 0xee(%rsp)
               	movb	%sil, 0xef(%rsp)
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
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<probe_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	movsbq	%sil, %r12
               	movq	%rbx, %r11
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
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movq	%r12, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x40(%rbp)
               	movb	%al, -0x3f(%rbp)
               	movb	%al, -0x3e(%rbp)
               	movb	%al, -0x3d(%rbp)
               	movb	%al, -0x3c(%rbp)
               	movb	%al, -0x3b(%rbp)
               	movb	%al, -0x3a(%rbp)
               	movb	%al, -0x39(%rbp)
               	movb	%al, -0x38(%rbp)
               	movb	%al, -0x37(%rbp)
               	movb	%al, -0x36(%rbp)
               	movb	%al, -0x35(%rbp)
               	movb	%al, -0x34(%rbp)
               	movb	%al, -0x33(%rbp)
               	movb	%al, -0x32(%rbp)
               	movb	%al, -0x31(%rbp)
               	movb	%al, -0x30(%rbp)
               	movb	%al, -0x2f(%rbp)
               	movb	%al, -0x2e(%rbp)
               	movb	%al, -0x2d(%rbp)
               	movb	%al, -0x2c(%rbp)
               	movb	%al, -0x2b(%rbp)
               	movb	%al, -0x2a(%rbp)
               	movb	%al, -0x29(%rbp)
               	movb	%al, -0x28(%rbp)
               	movb	%al, -0x27(%rbp)
               	movb	%al, -0x26(%rbp)
               	movb	%al, -0x25(%rbp)
               	movb	%al, -0x24(%rbp)
               	movb	%al, -0x23(%rbp)
               	movb	%al, -0x22(%rbp)
               	movb	%al, -0x21(%rbp)
               	andq	$0xf, %rcx
               	leaq	-0x20(%rbp), %rdx
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
               	leaq	-0x1(%rbx), %rcx
               	movslq	%ecx, %rcx
               	movsbq	(%r13,%rcx), %rcx
               	addq	%rcx, %rax
               	subq	%r12, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	%rdi, -0x20(%rbp)
               	callq	<addr>
               	movq	-0x20(%rbp), %rcx
               	subq	$0x2, %rcx
               	addq	%rax, %rcx
               	leaq	0x40(%rsp), %rdx
               	movl	$0x2, %eax
               	movb	%al, 0x40(%rsp)
               	movb	%al, 0x41(%rsp)
               	movb	%al, 0x42(%rsp)
               	movb	%al, 0x43(%rsp)
               	movb	%al, 0x44(%rsp)
               	movb	%al, 0x45(%rsp)
               	movb	%al, 0x46(%rsp)
               	movb	%al, 0x47(%rsp)
               	movb	%al, 0x48(%rsp)
               	movb	%al, 0x49(%rsp)
               	movb	%al, 0x4a(%rsp)
               	movb	%al, 0x4b(%rsp)
               	movb	%al, 0x4c(%rsp)
               	movb	%al, 0x4d(%rsp)
               	movb	%al, 0x4e(%rsp)
               	movb	%al, 0x4f(%rsp)
               	movb	%al, 0x50(%rsp)
               	movb	%al, 0x51(%rsp)
               	movb	%al, 0x52(%rsp)
               	movb	%al, 0x53(%rsp)
               	movb	%al, 0x54(%rsp)
               	movb	%al, 0x55(%rsp)
               	movb	%al, 0x56(%rsp)
               	movb	%al, 0x57(%rsp)
               	movb	%al, 0x58(%rsp)
               	movb	%al, 0x59(%rsp)
               	movb	%al, 0x5a(%rsp)
               	movb	%al, 0x5b(%rsp)
               	movb	%al, 0x5c(%rsp)
               	movb	%al, 0x5d(%rsp)
               	movb	%al, 0x5e(%rsp)
               	movb	%al, 0x5f(%rsp)
               	andq	$0xf, %rdx
               	addq	%rdx, %rcx
               	leaq	0x60(%rsp), %rdx
               	movb	%al, 0x60(%rsp)
               	movb	%al, 0x61(%rsp)
               	movb	%al, 0x62(%rsp)
               	movb	%al, 0x63(%rsp)
               	movb	%al, 0x64(%rsp)
               	movb	%al, 0x65(%rsp)
               	movb	%al, 0x66(%rsp)
               	movb	%al, 0x67(%rsp)
               	movb	%al, 0x68(%rsp)
               	movb	%al, 0x69(%rsp)
               	movb	%al, 0x6a(%rsp)
               	movb	%al, 0x6b(%rsp)
               	movb	%al, 0x6c(%rsp)
               	movb	%al, 0x6d(%rsp)
               	movb	%al, 0x6e(%rsp)
               	movb	%al, 0x6f(%rsp)
               	andq	$0xf, %rdx
               	addq	%rdx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
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
               	subq	%rcx, %rax
               	leaq	0x70(%rsp), %rcx
               	movb	%sil, 0x70(%rsp)
               	movb	%sil, 0x71(%rsp)
               	movb	%sil, 0x72(%rsp)
               	movb	%sil, 0x73(%rsp)
               	movb	%sil, 0x74(%rsp)
               	movb	%sil, 0x75(%rsp)
               	movb	%sil, 0x76(%rsp)
               	movb	%sil, 0x77(%rsp)
               	movb	%sil, 0x78(%rsp)
               	movb	%sil, 0x79(%rsp)
               	movb	%sil, 0x7a(%rsp)
               	movb	%sil, 0x7b(%rsp)
               	movb	%sil, 0x7c(%rsp)
               	movb	%sil, 0x7d(%rsp)
               	movb	%sil, 0x7e(%rsp)
               	movb	%sil, 0x7f(%rsp)
               	movb	%sil, 0x80(%rsp)
               	movb	%sil, 0x81(%rsp)
               	movb	%sil, 0x82(%rsp)
               	movb	%sil, 0x83(%rsp)
               	movb	%sil, 0x84(%rsp)
               	movb	%sil, 0x85(%rsp)
               	movb	%sil, 0x86(%rsp)
               	movb	%sil, 0x87(%rsp)
               	movb	%sil, 0x88(%rsp)
               	movb	%sil, 0x89(%rsp)
               	movb	%sil, 0x8a(%rsp)
               	movb	%sil, 0x8b(%rsp)
               	movb	%sil, 0x8c(%rsp)
               	movb	%sil, 0x8d(%rsp)
               	movb	%sil, 0x8e(%rsp)
               	movb	%sil, 0x8f(%rsp)
               	andq	$0xf, %rcx
               	addq	%rcx, %rax
               	leaq	0x90(%rsp), %rcx
               	movb	%sil, 0x90(%rsp)
               	movb	%sil, 0x91(%rsp)
               	movb	%sil, 0x92(%rsp)
               	movb	%sil, 0x93(%rsp)
               	movb	%sil, 0x94(%rsp)
               	movb	%sil, 0x95(%rsp)
               	movb	%sil, 0x96(%rsp)
               	movb	%sil, 0x97(%rsp)
               	movb	%sil, 0x98(%rsp)
               	movb	%sil, 0x99(%rsp)
               	movb	%sil, 0x9a(%rsp)
               	movb	%sil, 0x9b(%rsp)
               	movb	%sil, 0x9c(%rsp)
               	movb	%sil, 0x9d(%rsp)
               	movb	%sil, 0x9e(%rsp)
               	movb	%sil, 0x9f(%rsp)
               	andq	$0xf, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	(%rsp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	addq	%rbx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
