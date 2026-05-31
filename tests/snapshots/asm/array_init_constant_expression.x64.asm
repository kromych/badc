
array_init_constant_expression.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x10, %r9
               	je	0x400254 <.text+0x34>
               	movl	$0xb, %eax
               	retq
               	leaq	0xfe75(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x80, %r11
               	je	0x40027f <.text+0x5f>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfe4a(%rip), %rax      # 0x4100d0
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x4, %rax
               	je	0x4002a6 <.text+0x86>
               	movl	$0xd, %eax
               	retq
               	leaq	0xfe33(%rip), %r11      # 0x4100e0
               	movslq	(%r11), %rax
               	cmpq	$0x90, %rax
               	je	0x4002c3 <.text+0xa3>
               	movl	$0xe, %eax
               	retq
               	leaq	0xfe16(%rip), %r11      # 0x4100e0
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x94, %r11
               	je	0x4002ee <.text+0xce>
               	movl	$0xf, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfdeb(%rip), %rax      # 0x4100e0
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x10, %rax
               	je	0x400315 <.text+0xf5>
               	movl	$0x10, %eax
               	retq
               	leaq	0xfdd4(%rip), %r11      # 0x4100f0
               	movslq	(%r11), %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	je	0x400332 <.text+0x112>
               	movl	$0x11, %eax
               	retq
               	leaq	0xfdb7(%rip), %r11      # 0x4100f0
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x40, %r11
               	je	0x40035d <.text+0x13d>
               	movl	$0x12, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd94(%rip), %rax      # 0x4100f8
               	movslq	(%rax), %r11
               	cmpq	$0x11, %r11
               	je	0x40037e <.text+0x15e>
               	movl	$0x13, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd73(%rip), %rax      # 0x4100f8
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x70, %rax
               	je	0x4003a5 <.text+0x185>
               	movl	$0x14, %eax
               	retq
               	leaq	0xfd4c(%rip), %r11      # 0x4100f8
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x30, %r11
               	je	0x4003d0 <.text+0x1b0>
               	movl	$0x15, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd31(%rip), %rax      # 0x410108
               	movslq	(%rax), %r11
               	cmpq	$0x90, %r11
               	je	0x4003f1 <.text+0x1d1>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd10(%rip), %rax      # 0x410108
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x10, %rax
               	je	0x400418 <.text+0x1f8>
               	movl	$0x17, %eax
               	retq
               	leaq	0xfce9(%rip), %r11      # 0x410108
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x4, %r11
               	je	0x400443 <.text+0x223>
               	movl	$0x18, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfcbe(%rip), %rax      # 0x410108
               	movq	%rax, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x14, %rax
               	je	0x40046a <.text+0x24a>
               	movl	$0x19, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
