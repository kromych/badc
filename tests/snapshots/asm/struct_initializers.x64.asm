
struct_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400257 <.text+0x37>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfe54(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x1, %r9
               	je	0x4002b4 <.text+0x94>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe15(%rip), %r11      # 0x4100d0
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rbx
               	movl	$0x2, %r12d
               	movl	$0x3, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %rdi
               	cmpq	$0x5, %rdi
               	je	0x400317 <.text+0xf7>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfdb2(%rip), %r14      # 0x4100d0
               	movq	%r14, %rdi
               	addq	$0x10, %rdi
               	movq	(%rdi), %r15
               	movl	$0xa, %r14d
               	movl	$0x4, %ebx
               	movq	%r15, %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	%rax, %r12
               	cmpq	$0x6, %r12
               	je	0x40037a <.text+0x15a>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd4f(%rip), %rbx      # 0x4100d0
               	movq	%rbx, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	movq	%r12, %rbx
               	xorq	$0x64, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	je	0x4003db <.text+0x1bb>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd16(%rip), %rbx      # 0x4100f8
               	movslq	(%rbx), %r12
               	cmpq	$0x2, %r12
               	je	0x40041a <.text+0x1fa>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcd7(%rip), %rbx      # 0x4100f8
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r15
               	movl	$0x7, %ebx
               	movl	$0x8, %r12d
               	movq	%r15, %r11
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	movq	%rax, %r14
               	cmpq	$0xf, %r14
               	je	0x40047e <.text+0x25e>
               	movl	$0x6, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc73(%rip), %r12      # 0x4100f8
               	movq	%r12, %r14
               	addq	$0x18, %r14
               	movq	(%r14), %r12
               	movzbq	(%r12), %r14
               	movq	%r14, %r12
               	xorq	$0x61, %r12
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r12, %r14
               	cmpq	$0x0, %r14
               	je	0x4004df <.text+0x2bf>
               	movl	$0x7, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc3a(%rip), %r12      # 0x410120
               	movslq	(%r12), %r14
               	cmpq	$0x3, %r14
               	je	0x40051f <.text+0x2ff>
               	movl	$0x8, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbfa(%rip), %r12      # 0x410120
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r15
               	movl	$0x1, %r12d
               	movq	%r15, %r11
               	movq	%r12, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	movq	%rax, %rbx
               	cmpq	$0x2, %rbx
               	je	0x40057c <.text+0x35c>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb9d(%rip), %r12      # 0x410120
               	movq	%r12, %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %r14
               	movl	$0x5, %r12d
               	movl	$0x1, %ebx
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	%rax, %r15
               	cmpq	$0x4, %r15
               	je	0x4005df <.text+0x3bf>
               	movl	$0xa, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb62(%rip), %rbx      # 0x410148
               	movslq	(%rbx), %r15
               	cmpq	$0xa, %r15
               	je	0x40061e <.text+0x3fe>
               	movl	$0xb, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb23(%rip), %rbx      # 0x410148
               	movq	%rbx, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rbx
               	cmpq	$0x14, %rbx
               	je	0x400666 <.text+0x446>
               	movl	$0xc, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfae3(%rip), %r15      # 0x410150
               	movslq	(%r15), %rbx
               	cmpq	$0x1, %rbx
               	je	0x4006a4 <.text+0x484>
               	movl	$0xd, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfaa5(%rip), %r15      # 0x410150
               	movq	%r15, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r15
               	cmpq	$0x2, %r15
               	je	0x4006ed <.text+0x4cd>
               	movl	$0xe, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
