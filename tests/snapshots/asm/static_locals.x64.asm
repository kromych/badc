
static_locals.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400316 <.text+0xe6>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	leaq	0xfe92(%rip), %r11      # 0x4100e0
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	movslq	%edi, %r11
               	cmpq	$0x0, %r11
               	je	0x400297 <.text+0x67>
               	leaq	0xfe6c(%rip), %r9       # 0x4100e8
               	movl	$0x64, %r11d
               	movl	%r11d, (%r9)
               	leaq	0xfe64(%rip), %r8       # 0x4100f0
               	xorq	%r11, %r11
               	movl	%r11d, (%r8)
               	jmp	0x400297 <.text+0x67>
               	leaq	0xfe4a(%rip), %r11      # 0x4100e8
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	leaq	0xfe38(%rip), %r9       # 0x4100f0
               	movslq	(%r9), %r8
               	movslq	(%r11), %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%r9)
               	movslq	(%r11), %rdi
               	movslq	(%r9), %r11
               	movq	%rdi, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	leaq	0xfe17(%rip), %r11      # 0x4100f8
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	leaq	0xfe01(%rip), %r11      # 0x410100
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %r11
               	cmpq	$0x1, %r11
               	je	0x400366 <.text+0x136>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %r9
               	cmpq	$0x2, %r9
               	je	0x40039e <.text+0x16e>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rbx
               	cmpq	$0x3, %rbx
               	je	0x4003d5 <.text+0x1a5>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rdi
               	callq	0x400265 <.text+0x35>
               	movq	%rax, %rbx
               	cmpq	$0xca, %rbx
               	je	0x400412 <.text+0x1e2>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x400265 <.text+0x35>
               	movq	%rax, %rbx
               	cmpq	$0x131, %rbx            # imm = 0x131
               	je	0x40044f <.text+0x21f>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	movq	%r14, %rdi
               	callq	0x400265 <.text+0x35>
               	movq	%rax, %rbx
               	cmpq	$0xca, %rbx
               	je	0x400490 <.text+0x260>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002da <.text+0xaa>
               	movq	%rax, %r14
               	cmpq	$0x1, %r14
               	je	0x4004c7 <.text+0x297>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002da <.text+0xaa>
               	movq	%rax, %r12
               	cmpq	$0x2, %r12
               	je	0x4004ff <.text+0x2cf>
               	movl	$0x8, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002f8 <.text+0xc8>
               	movq	%rax, %rbx
               	cmpq	$0x3e9, %rbx            # imm = 0x3E9
               	je	0x400537 <.text+0x307>
               	movl	$0x9, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002f8 <.text+0xc8>
               	movq	%rax, %r14
               	cmpq	$0x3ea, %r14            # imm = 0x3EA
               	je	0x40056e <.text+0x33e>
               	movl	$0xa, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002da <.text+0xaa>
               	movq	%rax, %r12
               	cmpq	$0x3, %r12
               	je	0x4005a6 <.text+0x376>
               	movl	$0xb, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
